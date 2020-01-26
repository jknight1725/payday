# frozen_string_literal: true
require_relative 'board_factory'
require_relative 'deal_deck_factory'
require_relative 'mail_deck'
require_relative 'player'
require_relative 'game_prompt'
require 'colorize'

class Game
  include GamePrompt
  attr_accessor :players, :town_pot, :score_board
  attr_reader :mail_deck, :deal_deck, :board, :months_to_play

  def initialize(args={})
    args = defaults.merge args
    @players = args[:players]
    @mail_deck = args[:mail_deck]
    @deal_deck = args[:deal_deck]
    @board =  args[:game_board]
    @months_to_play = args[:months]
    @town_pot = 0
    @score_board = []
  end

  def defaults
    {
        players: [Player.new(name: 'James'), Player.new(name: 'Megan')],
        mail_deck: MailDeck.new,
        deal_deck: DealDeckFactory::create('default'),
        game_board: BoardFactory::create('default'),
        months: 6
    }
  end

  def to_h
    {
        players: players,
        mail_deck: mail_deck,
        deal_deck: deal_deck.to_h,
        board: board,
        months_to_play: months_to_play,
        town_pot: town_pot,
        score_board: score_board
    }
  end

  def run
    players.each(&method(:turn)) until players.empty?
    results
  end

  def turn(player)
    tile = move(player)
    action(tile, player)
    GamePrompt.end_turn(player.name)
    game_over(player) if player.months_played == months_to_play
  end

  def move(player)
    value = rand(1..6)
    position = player.move(value)
    puts GamePrompt.roll(player.name, value, position)
    show_board(position)
    pot_winner(player) if value == 6 && town_pot.positive?
    board[position]
  end

  def game_over(player)
    score_board << {name: player.name, score: player.score}
    puts GamePrompt.game_over(player.name, months_to_play, player.score)
    self.players.delete(player)
  end

  def results
    puts GamePrompt.results
    score_board.sort_by {|h| h[:score]}.reverse_each {|p| puts "#{p[:name]}\t#{p[:score]}" }
  end

  # TODO: poker
  def action(tile, player)
    case tile[:effect]
    when 'mail'
      send_mail(player, tile[:amount])
    when 'deal'
      send_deal(player)
    when 'buyer'
      buyer(player)
    when 'poker'
      nil
    when 'bill'
      financial_event(player: player, name: tile[:name], amount: tile[:amount], type: negative)
    when 'windfall'
      financial_event(player: player, name: tile[:name], amount: tile[:amount], type: positive)
    when 'election'
      town_election(tile[:amount])
    when 'dst'
      dst
    when 'lotto'
      lotto_winner(player)
    when 'payday'
      payday(player)
    else
      nil
    end
  end

  def send_mail(player, amount)
    amount.times { player.process_letter(mail_card) }
  end

  def send_deal(player)
    player.process_deal(deal_card)
  end

  def financial_event(args)
    args[:player].wallet -= args[:amount] if args[:type] == negative
    args[:player].wallet += args[:amount] if args[:type] == positive
    puts "#{args[:player].name} #{args[:type]} #{args[:amount]} for #{args[:name]}\n"
  end

  def buyer(player)
    sold = player.sell_deal
    commission_roll(sold.commission) if sold
  end

  def dst
    puts GamePrompt.dst
    players.each do |player|
      player.position -= 1 unless player.position == 31
      tile = board[player.position]
      action(tile, player)
    end
  end

  def lotto_winner(player)
    financial_event(player: player, amount: player.lotto, name: 'lottery winner', type: positive)
    player.lotto = 0
  end

  def pot_winner(player)
    financial_event(player: player, amount: town_pot, name: 'town pot', type: positive)
    self.town_pot = 0
  end

  def commission_roll(commission)
    winner = players.sample
    financial_event(player: winner, amount: commission, name: 'commission', type: positive)
  end

  def town_election(amount)
    players.each do |player|
      financial_event(player: player, amount: amount, name: 'town election', type: negative)
      self.town_pot += amount
    end
  end

  def payday(player)
    player.payday
  end

  def deal_card
    deal_deck.draw_card
  end

  def mail_card
    mail_deck.draw_card
  end

  def show_board(position)
    newline_if_sunday = ->(day){puts "\n" if (day+1)%7==0 || day == 31}
    player_at_pos = ->(day){day == position}
    board.each do |k,v|
      day = "#{k}\t #{v[:effect]}".ljust(14, " ")
      print player_at_pos[k] ?  day.red :  day
      newline_if_sunday[k]
      end
  end

  def positive
    'receives'
  end

  def negative
    'pays'
  end

end
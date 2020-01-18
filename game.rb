# frozen_string_literal: true

require_relative 'deal_deck'
require_relative 'mail_deck'
require_relative 'player'
require_relative 'board'

class Game

  attr_accessor :players, :town_pot, :score_board
  attr_reader :mail_deck, :deal_deck, :board, :months_to_play

  def initialize(args)
    args = defaults.merge args
    @players = args[:players]
    @mail_deck = args[:mail_deck]
    @deal_deck = args[:deal_deck]
    @months_to_play = args[:months]
    @board =  args[:game_board]
    @town_pot = 0
    @score_board = []
  end

  def run
    players.each(&method(:turn))
    players.empty? ? nil : run
  end

  def turn(player)
    roll = rand(1..6)
    pot_winner(player) if roll == 6 && town_pot.positive?
    position = player.move(roll)
    tile = board[position]
    puts "#{player.name} rolled a #{roll} landed on day #{position}"
    action(tile, player)
    game_over(player) if player.months_played == months_to_play
  end

  def game_over(player)
    score_board << {name: player.name, score: player.score}
    players.delete(player)
  end

  def results
    puts "\nFinal Scores!\n"
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
    puts "#{args[:player].name} #{args[:type]} #{args[:amount]} for #{args[:name]}"
  end

  def buyer(player)
    sold = player.sell_deal
    commission_roll(sold.commission) if sold
  end

  def dst
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

  def defaults
    {
      players: [Player.new('James'), Player.new('Megan')],
      mail_deck: MailDeck.new,
      deal_deck: DealDeck.new,
      months: 6,
      game_board: Board.default_tiles
    }
  end

  def positive
    'receives'
  end

  def negative
    'pays'
  end

end

g = Game.new({})
# g.turn
# puts g.players
#puts g.action(g.board[4], g.players[0])
#puts g.action(g.board[31], g.players[0])
unless g.run
  g.results
end

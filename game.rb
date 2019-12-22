# frozen_string_literal: true

require_relative 'deal_deck'
require_relative 'mail_deck'
require_relative 'player'
require_relative 'board'

class Game

  attr_accessor :players
  attr_reader :mail_deck, :deal_deck, :board

  def initialize(args)
    @players = args[:players]
    @mail_deck = args[:mail_deck]
    @deal_deck = args[:deal_deck]
    @board = Board.tiles
  end

  def turn
    players.each do |player|
      position = player.move
      tile = board[position]
      action(tile, player)
    end
  end

  def action(tile, player)
    case tile[:effect]
    when 'start'
      nil
    when 'mail'
      send_mail(player, tile[:amount])
    when 'deal'
      send_deal(player)
    when 'none'
      nil
    when 'buyer'
      nil
    when 'poker'
      nil
    when 'bill'
      nil
    when 'windfall'
      nil
    when 'election'
      nil
    when 'dst'
      nil
    when 'lotto'
      nil
    when 'payday'
      nil
    end
  end

  def send_mail(player, amount)
    amount.times { player.process_letter(mail_deck.draw_card) }
  end

  def send_deal(player)
    player.process_deal(deal_deck.draw_card)
  end
end

default_args = {
  players: [Player.new('James'), Player.new('Megan')],
  mail_deck: MailDeck.new,
  deal_deck: DealDeck.new
}
g = Game.new(default_args)
g.turn
puts g.players
# puts g.action(g.board[4], g.players[0])
# puts g.players[0]


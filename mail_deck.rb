require_relative 'mail_cards'
class MailDeck
  include MailCards
  def draw_card
    MailCards.cards(rand(1..64))
  end
end
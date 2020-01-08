# frozen_string_literal: true

require_relative 'record_pad'
require_relative 'player_prompt'
class Player
  include PlayerPrompt
  attr_accessor :wallet, :deals, :car_ins, :med_ins, :position, :lotto
  attr_reader :bank, :name

  def initialize(name)
    @name = name
    @bank = RecordPad.new
    @wallet = 325
    @lotto = 0
    @position = 0
    @med_ins = false
    @car_ins = false
    @deals = []
  end

  def withdrawal
    puts PlayerPrompt.withdrawal
    amount = gets.to_i
    bank_withdrawal amount
  end

  def deposit
    puts PlayerPrompt.deposit(wallet)
    cash = [0, gets.to_i].max
    cash > wallet ? bank_deposit(wallet) : bank_deposit(cash)
  end

  def move
    amount = roll
    position + amount > 31 ? self.position = 0 : self.position += amount
    self.position = 0 if position.negative?
    position
  end

  def score
    wallet + bank.savings - bank.loan
  end

  def to_s
    "#{name} #{bank}\nWallet:\t#{wallet}\nTotal:\t#{score}\n" \
    "med insurance:\t#{med_ins}\ncar insurance:\t#{car_ins}\n" \
    "Deals\n#{deals.join("\n")}"
  end

  def bank_withdrawal(cash)
    bank.withdrawal cash
    self.wallet += cash
  end

  def bank_deposit(cash)
    bank.deposit cash
    self.wallet -= cash
  end

  def roll
    rand(1..6)
  end

  def process_letter(letter)
    type = letter.type
    cost = letter.cost
    puts PlayerPrompt.letter(name, letter)
    case type
    when 'bill'
      self.wallet -= cost
    when 'med_bill'
      self.wallet -= cost unless med_ins
    when 'car_bill'
      self.wallet -= cost unless car_ins
    when 'windfall'
      self.wallet += cost
    when 'lottery'
      self.lotto += cost
    when 'car_insurance'
      buy_insurance? [type, cost] unless car_ins
    when 'med_insurance'
      buy_insurance? [type, cost] unless med_ins
    when 'swellfare'
      use_swellfare? if bank.loan.positive?
    end
  end

  def process_deal(deal)
    price = deal.cost
    puts PlayerPrompt.deal(name, deal)
    if confirm_purchase?(price)
      make_purchase(price)
      deals << deal
      nil
    end
  end

  def sell_deal
    unless deals.empty?
      best_to_sell = deals.max_by(&:value)
      self.wallet += best_to_sell.value
      deals.delete(best_to_sell)
      puts PlayerPrompt.deal_sold(name, best_to_sell)
      best_to_sell
    end
  end

  def buy_insurance?(insurance)
    plan, price = insurance
    puts PlayerPrompt.insurance(name, plan)
    if confirm_purchase?(price)
      make_purchase(price)
      self.med_ins = true if plan.equal? 'med_insurance'
      self.car_ins = true if plan.equal? 'car_insurance'
    end
  end

  def use_swellfare?
    puts PlayerPrompt.swellfare
    if gets.to_i == 1
      puts PlayerPrompt.swellfare_bet(wallet)
      bet = gets.to_i
      bet = 0 if bet.negative? || wallet < bet
      bet = 100 if bet > 100
      self.wallet += swellfare(bet)
    end
  end

  def swellfare(bet)
    value = roll
    puts PlayerPrompt.swellfare_result(value, bet)
    value > 4 ? bet * 10 : -bet
  end

  def confirm_purchase?(price)
    puts PlayerPrompt.purchase(price)
    confirm = gets.to_i
    confirm == 1
  end

  def make_purchase(price)
    bank_withdrawal price if wallet < price
    self.wallet -= price
  end
end
# p = Player.new('p')

# bank test
# p.withdrawal
# p.deposit
# puts p

# move test
# puts p.position
# p.move 31
# puts p.position
# p.move 1
# puts p.position
# p.move -1
# puts p.position

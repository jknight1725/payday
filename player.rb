# frozen_string_literal: true

require_relative 'record_pad'
require_relative 'player_prompt'
class Player
  include PlayerPrompt
  attr_accessor :wallet, :deals, :car_ins, :med_ins, :position, :lotto, :months_played
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
    @months_played = 0
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

  def move(distance)
    self.position = 0 if position == 31
    position + distance > 31 ? self.position = 31 : self.position += distance
    month_elapsed if position == 31
    position
  end

  def month_elapsed
    self.months_played += 1
    self.lotto = 0
  end

  def score
    wallet + bank.savings - bank.loan
  end

  def to_s
    "Here is your bank statement for the month\n" \
    "#{name} #{bank}\nWallet:\t#{wallet}\nTotal:\t#{score}\n" \
    "med insurance:\t#{med_ins}\ncar insurance:\t#{car_ins}\n" \
    "Deals:\n#{deals.join("\n")}\n"
  end

  def bank_withdrawal(cash)
    bank.withdrawal cash
    self.wallet += cash
  end

  def bank_deposit(cash)
    bank.deposit cash
    self.wallet -= cash
  end

  def process_letter(letter)
    type = letter.type
    cost = letter.cost
    puts PlayerPrompt.letter(name, letter)
    case type
    when 'bill'
      make_purchase cost
    when 'med_bill'
      make_purchase cost unless med_ins
    when 'car_bill'
      make_purchase cost unless car_ins
    when 'windfall'
      self.wallet += cost
    when 'lottery'
      self.lotto += cost
    when 'med_insurance'
      buy_insurance? [type, cost] unless med_ins
    when 'car_insurance'
      buy_insurance? [type, cost] unless car_ins
    when 'swellfare'
      use_swellfare? if bank.loan.positive?
    else
      nil
    end
  end

  def process_deal(deal)
    price = deal.cost
    puts PlayerPrompt.deal(name, deal)
    if confirm_purchase?(price)
      make_purchase(price)
      deals << deal
    end
    nil
  end

  def confirm_purchase?(price)
    puts PlayerPrompt.purchase(price)
    confirm = gets.to_i
    confirm == 1
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
    roll = rand(1..6)
    puts PlayerPrompt.swellfare_result(roll, bet)
    roll > 4 ? bet * 10 : -bet
  end

  def make_purchase(price)
    bank_withdrawal price if wallet < price
    self.wallet -= price
  end

  def payday
    self.wallet += 325
    self.wallet = bank.apply_interest(wallet)
    puts PlayerPrompt.payday(self)
    deposit
    puts PlayerPrompt.end_payday(self)
  end
end

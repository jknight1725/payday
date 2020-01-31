# frozen_string_literal: true
require_relative 'record_pad'
require_relative 'player_prompt'
class Player
  include PlayerPrompt
  attr_accessor :wallet, :deals, :car_ins, :med_ins, :position, :lotto, :months_played
  attr_reader :bank, :name

  def initialize(args={})
    args = defaults.merge args
    @name = args[:name]
    @bank = args[:bank]
    @wallet = args[:wallet]
    @lotto = args[:lotto]
    @position = args[:position]
    @months_played = args[:months]
    @med_ins = args[:med]
    @car_ins = args[:car]
    @deals = args[:deals]
  end

  def defaults
    {
        name: 'Player',
        bank: RecordPad.new,
        wallet: 325,
        lotto: 0,
        position: 0,
        months: 0,
        med: false,
        car: false,
        deals: []
    }
  end

  def to_s
    "Here is your bank statement for month #{months_played} #{name} \n" \
    "#{bank}\nWallet:\t#{wallet}\nTotal:\t#{score}\n" \
    "med insurance:\t#{med_ins}\ncar insurance:\t#{car_ins}\n" \
    "Deals:\n#{deals.join("\n")}\n"
  end

  def to_h
    {
        name: name,
        bank: bank.to_h,
        wallet: wallet,
        lotto: lotto,
        position: position,
        months_played: months_played,
        med: med_ins,
        car: car_ins,
        deals: self.deals.map{|d| d.to_h }
    }
  end

  def withdrawal
    puts PlayerPrompt.withdrawal
    cash = gets.to_i
    bank_withdrawal cash
  end

  def deposit
    puts PlayerPrompt.deposit(wallet)
    cash = [0, gets.to_i].max
    cash > wallet ? bank_deposit(wallet) : bank_deposit(cash)
  end

  def bank_withdrawal(cash)
    bank.withdrawal cash
    self.wallet += cash
  end

  def bank_deposit(cash)
    bank.deposit cash
    self.wallet -= cash
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
    wallet + bank.total
  end

  def process_letter(letter)
    type = letter.type
    cost = letter.cost
    puts PlayerPrompt.letter(name, letter)
    case type
    when 'bill'
      make_purchase cost
    when 'med bill'
      make_purchase cost unless med_ins
    when 'car bill'
      make_purchase cost unless car_ins
    when 'windfall'
      self.wallet += cost
    when 'lottery'
      self.lotto += cost
    when 'med insurance'
      buy_insurance?(cost, type) unless med_ins
    when 'car insurance'
      buy_insurance?(cost, type) unless car_ins
    when 'swellfare'
      use_swellfare? if score.negative?
    else
      nil
    end
  end

  def confirm_purchase?(price)
    PlayerPrompt.confirm(PlayerPrompt.purchase(price))
  end

  def make_purchase(price)
    bank_withdrawal price if wallet < price
    self.wallet -= price
  end

  def process_deal(deal)
    puts PlayerPrompt.deal(name, deal, deals.length)
    if confirm_purchase?(deal.cost)
      make_purchase(deal.cost)
      self.deals << deal
    end
    nil
  end

  def sell_deal
    unless deals.empty?
      best_to_sell = deals.max_by(&:value)
      self.wallet += best_to_sell.value
      self.deals.delete(best_to_sell)
      puts PlayerPrompt.deal_sold(name, best_to_sell)
      best_to_sell
    end
  end

  def buy_insurance?(price, plan)
    if confirm_purchase?(price)
      make_purchase(price)
      self.med_ins = true if plan.equal? 'med insurance'
      self.car_ins = true if plan.equal? 'car insurance'
    end
  end

  def use_swellfare?
    if PlayerPrompt.confirm(PlayerPrompt.swellfare)
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

  def payday
    self.wallet += 325
    self.wallet = bank.apply_interest(wallet)
    puts PlayerPrompt.payday(name)
    puts bank
    deposit
    puts PlayerPrompt.end_payday(self)
  end
end

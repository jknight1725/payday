# frozen_string_literal: true

require_relative 'record_pad'
class Player
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
    puts "Enter an amount to withdraw:\t"
    amount = gets.to_i
    bank_withdrawal amount
  end

  def deposit
    puts "Wallet: #{wallet}\nDeposit Amount:\t"
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

  #private

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
    puts "#{name} You got mail! #{letter}"
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
    puts "#{name} You got a Deal!\n#{deal}" \
         "Press 1 to buy for #{price} (loan will be taken if you cannot afford)\n" \
         'Press any other key to decline'
    opt_in = gets.to_i
    if opt_in == 1
      bank_withdrawal price if wallet < price
      self.wallet -= price
      deals << deal
    end
  end

  def buy_insurance?(insurance)
    plan, price = insurance
    puts "Would you like to buy #{plan} for #{price} " \
    'Press 1 to buy insurance, any other key to decline'
    opt_in = gets.to_i
    if opt_in == 1
      bank_withdrawal price if wallet < price
      self.wallet -= price
      self.med_ins = true if plan.equal? 'med_insurance'
      self.car_ins = true if plan.equal? 'car_insurance'
    end
  end

  def use_swellfare?
    puts "Roll a 5 or 6 win 10 times your bet! Otherwise you lose your bet\n" \
      "Enter 1 to use swellfare, any other key to decline\n"
    opt_in = gets.to_i
    if opt_in == 1
      puts "Wallet: #{wallet}\nBet Amount(max 100):\t"
      bet = gets.to_i
      bet = 0 if bet.negative? || wallet < bet
      bet = 100 if bet > 100
      self.wallet += swellfare bet
    end
  end

  def swellfare(bet)
    value = roll
    puts "You bet #{bet} You rolled a #{value}\n"
    value > 4 ? bet * 10 : -bet
  end
end
# p = Player.new('p')

# bank test
# p.withdrawal
# p.deposit
# puts p"

# move test
# puts p.position
# p.move 31
# puts p.position
# p.move 1
# puts p.position
# p.move -1
# puts p.position

module PlayerPrompt
  def self.withdrawal
    "Enter an amount to withdraw:\t"
  end

  def self.deposit(wallet)
    "Enter an amount to put towards loans or savings:\n"\
    "Wallet: #{wallet}\nDeposit Amount:\t"
  end

  def self.receive_msg(name)
    "#{name}! You got "
  end

  def self.letter(name, letter)
    receive_msg(name) << "mail! #{letter}"
  end

  def self.deal(name, deal, deals)
    receive_msg(name) << "a Deal!\n#{deal}You currently have #{deals} deals\n"
  end

  def self.deal_sold(name, deal)
    receive_msg(name) << "a buyer for your #{deal.name}\nSold for #{deal.value}\n"
  end

  def self.confirm(msg)
    puts msg
    puts "Press 1 to confirm. Press any other key to decline.\n"
    gets.to_i == 1
  end

  def self.purchase(price)
    "Would you like to buy for #{price}? (loan will be taken if you cannot afford)\n"
  end

  def self.swellfare
    "Roll a 5 or 6 and win 10 times your bet! Otherwise you lose your bet\n"
  end

  def self.swellfare_bet(wallet)
    "Wallet: #{wallet}\nBet Amount(max 100):\t"
  end

  def self.swellfare_result(value, bet)
    value > 4 ? result = 'win' : result = 'lose'
    "You bet #{bet} You rolled a #{value} You #{result}!\n"
  end

  def self.payday(name)
    "It's payday #{name}! 325 credits applied to your wallet\n"\
    "10 percent of any savings will be credited to your wallet as interest\n"\
    "20 percent of any loans will be deducted from your wallet as interest\n"
  end

  def self.end_payday(player)
    "End of payday! #{player}"
  end

end
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

  def self.deal(name, deal)
    receive_msg(name) << "a Deal!\n#{deal}"
  end

  def self.insurance(name, plan)
    receive_msg(name) << "an insurance offer!\n#{plan}"
  end

  def self.deal_sold(name, deal)
    receive_msg(name) << "a buyer for your #{deal}"
  end

  def self.purchase(price)
    "Press 1 to buy for #{price} (loan will be taken if you cannot afford)\n" \
    'Press any other key to decline'
  end

  def self.swellfare
    "Roll a 5 or 6 win 10 times your bet! Otherwise you lose your bet\n" \
      "Enter 1 to use swellfare, any other key to decline\n"
  end

  def self.swellfare_bet(wallet)
    "Wallet: #{wallet}\nBet Amount(max 100):\t"
  end

  def self.swellfare_result(value, bet)
    "You bet #{bet} You rolled a #{value}\n"
  end

  def self.payday(player)
    "It's payday! 325 credits applied to your wallet\n"\
    "10 percent of any savings will be credited to your wallet as interest\n"\
    "20 percent of any loans will be deducted from your wallet as interest\n"\
    "#{player}"
  end

  def self.end_payday(player)
    "End of payday! #{player}"
  end

end
# frozen_string_literal: true

class RecordPad
  attr_accessor :loan, :savings

  def initialize(args={})
    args = defaults.merge args
    @loan = args[:loan]
    @savings = args[:savings]
  end

  def defaults
    {
        loan: 0,
        savings: 0
    }
  end

  def to_h
    {
        loan: loan,
        savings: savings
    }
  end

  def deposit(cash)
    loan.positive? ? pay_loan(cash) : self.savings += cash
  end

  def withdrawal(cash)
    savings > cash ? self.savings -= cash : overdraft(cash)
  end

  def apply_interest(wallet)
    wallet -= (loan * 0.2)
    wallet += (savings * 0.1)
    wallet.to_i
  end

  def total
    savings - loan
  end

  def to_s
    "Bank Statement\nSavings\t#{savings}\nLoan\t#{loan}"
  end

  private

  def overdraft(cash)
    cash -= savings
    self.savings = 0
    self.loan += cash
  end

  def pay_loan(cash)
    cash > loan ? credit(cash) : self.loan -= cash
  end

  def credit(cash)
    cash -= loan
    self.loan = 0
    deposit(cash)
  end
end
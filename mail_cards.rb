# frozen_string_literal: true

module MailCards
  class Card
    attr_reader :type, :cost
    def initialize(args)
      @type = args[:type]
      @cost = args[:cost]
    end

    def to_s
      "#{type.capitalize} for #{cost}"
    end
  end

  def self.bill
    bills = [
      15, 15, 20, 20, 25,
      25, 25, 25, 30, 35,
      50, 50, 50, 60, 75,
      80, 90, 100, 125, 250,
      300, 500, 800
    ]
    Card.new(type: 'bill', cost: bills.sample)
  end

  def self.lottery_ticket
    lotto = [50, 100]
    Card.new(type: 'lottery', cost: lotto.sample)
  end

  def self.windfall
    windfalls = [20, 50, 150]
    Card.new(type: 'windfall', cost: windfalls.sample)
  end

  def self.med_bill
    med_bills = [15, 15, 20, 25, 85, 150, 150]
    Card.new(type: 'med bill', cost: med_bills.sample)
  end

  def self.car_bill
    car_bills = [25, 50, 50, 100, 100, 150]
    Card.new(type: 'car bill', cost: car_bills.sample)
  end

  def self.no_effect
    Card.new(type: 'no effect', cost: 0)
  end

  def self.car_insurance
    car_insurance = [200]
    Card.new(type: 'car insurance', cost: car_insurance.sample)
  end

  def self.med_insurance
    med_insurance = [150]
    Card.new(type: 'med insurance', cost: med_insurance.sample)
  end

  def self.swellfare
    Card.new(type: 'swellfare', cost: 0)
  end

  def self.cards(index)
    case index
    when 1..23
      bill
    when 24..27
      lottery_ticket
    when 28..30
      windfall
    when 31..37
      med_bill
    when 38..43
      car_bill
    when 44..56
      no_effect
    when 57..59
      car_insurance
    when 60..62
      med_insurance
    when 63..64
      swellfare
    else
      nil
    end
  end
end

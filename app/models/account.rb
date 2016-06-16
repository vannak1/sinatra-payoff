class Account < ActiveRecord::Base
  include Math
  belongs_to :user
  has_many :transactions

  def curr_balance
     transactions = self.transactions.collect{|t| t.amount}
     if !transactions.empty?
       self.balance - transactions.reduce(:+)
     else
       self.balance
     end
  end

  def due_date
    day = self.date.day < 29 ? self.date.day : 28
    today = Time.now.day
    day - today
  end

  def total_paid(options)
    mr = options[:interest] / 1200
    balance = options[:balance]
    total_cost = options[:balance]
    fincharge = 0.00
    min_payment = options[:min_payment]

    if mr > 0
      tmp1 = Math.log(1 - (mr * balance / min_payment))
      tmp2 = Math.log(1 + mr)
      num_months = ((tmp1 * -1) / tmp2).ceil
      total_cost = num_months * min_payment
      fincharge = total_cost - balance
    else
      if (balance % min_payment) == 0
        num_months = balance / min_payment
        total_cost = num_months * min_payment
      else
        num_months = balance / min_payment + 1.0
        total_cost = (num_months - 1.0) * min_payment
      end
    end
    {num_months: num_months, total_cost: total_cost.round(2), fincharge: fincharge.round(2)}
  end
end

class Account < ActiveRecord::Base
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
    monthly_rate = options[:interest] / 1200
    balance = options[:balance]
    total_cost = options[:balance]
    fincharge = 0.00
    min_payment = options[:min_payment]

    if monthly_rate > 0
      tmp1 = Math.log(1 - (monthly_rate * balance / min_payment))
      tmp2 = Math.log(1 + monthly_rate)
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

  def pay_off(options)
    monthly_rate = options[:interest] / 1200
    balance = options[:balance]
    payment = options[:payment]
    n = options[:month] * 30.3

    #B = A(1+i)**n - (P/i)[(1+i)**n - 1]
    tmp1 = balance * (1 + monthly_rate)**n
    tmp2 = payment / monthly_rate
    tmp3 = (1 + monthly_rate)**n - 1

    payoff = (tmp1 - tmp2 * tmp3).round(2)
  end
end

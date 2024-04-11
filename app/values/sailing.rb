require 'bigdecimal'

class Sailing
  GRANULARITY = 10_000

  attr_reader :origin_port, :destination_port, :departure_date, :arrival_date, :sailing_code, :rate, :rate_currency

  def initialize(sailing_obj)
    @origin_port = sailing_obj['origin_port']
    @destination_port = sailing_obj['destination_port']
    @departure_date = sailing_obj['departure_date']
    @arrival_date = sailing_obj['arrival_date']
    @sailing_code = sailing_obj['sailing_code']
    rate_obj = $rates_data.find { |r| r['sailing_code'] == sailing_code }
    @rate = rate_obj['rate']
    @rate_currency = rate_obj['rate_currency']
  end

  def eur_rate
    if rate_currency == 'EUR'
      rate.to_f
    else
      granulated_rate = (BigDecimal(rate)*GRANULARITY)
      granulated_rate_currency = (BigDecimal($exchange_rates_data[departure_date][rate_currency.downcase].to_s)*GRANULARITY)
      (granulated_rate / granulated_rate_currency).to_f.round(4)
    end
  end

  def edge
    show_attributes.merge({ eur_rate: eur_rate })
  end

  def show_attributes
    {
      origin_port: origin_port,
      destination_port: destination_port,
      departure_date: departure_date,
      arrival_date: arrival_date,
      sailing_code: sailing_code,
      rate: rate,
      rate_currency: rate_currency,
    }
  end
end

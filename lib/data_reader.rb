# The implementation of this module is just for reading data from json file and keeping it in memory,
# for consistent calculation in case where data can be updated dynamically.
# However it can be easily adjusted for reading data from API, or other source.

require_relative '../app/errors/no_data_error'

module DataReader

  # Read data from file
  def self.call(data_path = 'response.json')
    data = JSON.parse File.read(data_path)

    raise NoDataError unless data

    store_data(data)
  end

  private

  # Store data from file in memory for multiple usage
  def self.store_data(data)
    $sailings_data = data['sailings']
    $rates_data = data['rates']
    $exchange_rates_data = data['exchange_rates']
  end
end

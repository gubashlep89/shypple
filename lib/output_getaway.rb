# This module is added only for future adjustments. I assume that one of the next tasks will be
# to send the result in some API, placing it in some file or a database.

module OutputGetaway
  # @param codes [Array]([String]) Array of sailing codes.
  #
  # @return Array([Hash]) Return array of sailing objects with all required fields.
  def self.show_result(codes)
    result = codes.map do |code|
      Sailing.new($sailings_data.find { |r| r['sailing_code'] == code }).show_attributes
    end
    p result
  end
end

module InputReader
  # @return Array([String]) Return array of input parameters.
  def self.call
    raise ArgumentError, 'Wrong number of arguments' if ARGV.length > 2

    ARGV
  end
end
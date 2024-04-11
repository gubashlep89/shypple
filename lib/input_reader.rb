module InputReader
  def self.call
    raise ArgumentError, 'Wrong number of arguments' if ARGV.length > 2

    ARGV
  end
end
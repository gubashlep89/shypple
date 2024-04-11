# this module needs for prepare data for calculations and can be simply adjusted for future calculations

module DataProcessor
  def self.prepare_edges
    $sailings_data.map do |sailing|
      Sailing.new(sailing).edge
    end
  end
end

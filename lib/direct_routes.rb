# Module for calculations direct routes only

module DirectRoutes
  # @param edges [Array] Array of edge objects.
  # @param origin [String] Origin port.
  # @param destination [String] Destination port.
  #
  # @return Array([String]) Return array of sailings codes with the cheapest cost.
  def self.find_cheapest(edges, departure, destination)
    direct_sailings = edges.select { |s| s[:origin_port] == departure && s[:destination_port] == destination }
    return [] unless direct_sailings.any?

    [direct_sailings.sort { |a, b| a[:eur_rate] <=> b[:eur_rate] }.first[:sailing_code]]
  end
end

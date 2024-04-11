# Module for calculations direct routes only

module DirectRoutes
  def self.find_cheapest(edges, departure, destination)
    direct_sailings = edges.select { |s| s[:origin_port] == departure && s[:destination_port] == destination }
    sorted = direct_sailings.sort { |a, b| a[:eur_rate] <=> b[:eur_rate] }
    if sorted.any?
      [sorted.first[:sailing_code]]
    else
      []
    end
  end
end

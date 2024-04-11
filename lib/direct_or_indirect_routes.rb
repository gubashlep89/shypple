# Module for calculations direct or indirect routes

require 'set'

module DirectOrIndirectRoutes
  def self.find_cheapest(edges, origin, destination)
    graph = Hash.new { |h, k| h[k] = [] }
    edges.each do |edge|
      graph[edge[:origin_port]] << [edge[:destination_port], edge[:eur_rate], edge[:departure_date], edge[:arrival_date], edge[:sailing_code]]
    end

    priority_queue = []
    visited = Set.new

    priority_queue.push([origin, 0, []])

    until priority_queue.empty?
      current, cost, path, code = priority_queue.shift
      next if visited.include?(current)

      visited.add(current)
      path << [current, cost, code]

      return path.map { |p| p[2] if p[2] }.compact if current == destination

      if graph.key?(current)
        graph[current].each do |neighbor, rate, departure_date, arrival_date, sailing_code|
          priority_queue.push([neighbor, cost + rate, path, sailing_code])
        end
      end
      priority_queue.sort_by! { |node| node[1] }
    end

    []
  end

  def self.find_shortest(edges, origin, destination)
    # TODO
  end
end

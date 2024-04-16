# Module for calculations direct or indirect routes

require 'set'
require 'date'

module DirectOrIndirectRoutes

  # @param edges [Array] Array of edge objects.
  # @param origin [String] Origin port.
  # @param destination [String] Destination port.
  #
  # @return Array([String]) Return array of sailings codes with cheapest cost.
  def self.find_cheapest(edges, origin, destination)
    self.find_path(edges, origin, destination, 'cheapest')
  end

  # @param edges [Array] Array of edge objects.
  # @param origin [String] Origin port.
  # @param destination [String] Destination port.
  #
  # @return Array([String]) Return array of sailings codes with the fastest path.
  def self.find_fastest(edges, origin, destination)
    self.find_path(edges, origin, destination)
  end

  private

  # @param edges [Array] Array of edge objects.
  # @param origin [String] Origin port.
  # @param destination [String] Destination port.
  # @param condition [String] Provide which type of search we need.
  #
  # @return Array([String]) Return array of sailings codes.
  def self.find_path(edges, origin, destination, condition = 'fastest')
    graph = Hash.new { |h, k| h[k] = [] }

    edges.each do |edge|
      graph[edge[:origin_port]] << edge
    end

    return [] unless graph.keys.include?(origin)

    priority_queue = []
    visited = Set.new
    weights = {}
    previous = {}

    priority_queue.push([origin, 0])


    until priority_queue.empty?
      current_node, current_weight = priority_queue.shift

      next if visited.include?(current_node)

      visited.add(current_node)

      previous_edge = previous[current_node]
      checked_edges = get_edges(graph, current_node, previous_edge)

      # in case when the fastest path is invalid, we should try from the beginning without invalid edge
      if checked_edges.empty? && graph[previous_edge[:origin_port]].length > 1 && current_node != destination
        edges = edges.filter { |edge| edge[:sailing_code] != previous_edge[:sailing_code] }
        result = find_path(edges, origin, destination, condition)
        return result if result.any?
      end

      checked_edges.each do |edge|
        target = edge[:destination_port]
        target_weight = weights[target]
        edge_weight = if condition == 'fastest'
                        calculate_fastest_weight(previous_edge, edge)
                      else
                        edge[:eur_rate]
                      end
        new_weight = current_weight + edge_weight
        if target_weight.nil? || target_weight > new_weight
          weights[target] = new_weight
          previous[target] = edge
          priority_queue.push([target, new_weight])
        end
      end
      priority_queue.sort_by! { |node| node[1] }
    end

    # for future tasks
    # total_weight = weights[destination]
    path = []
    cursor = previous[destination]

    until cursor.nil?
      path << cursor
      origin_port = cursor[:origin_port]
      cursor = previous[origin_port]
    end

    path.reverse.map { |edge|  edge[:sailing_code]}
  end

  # @param prev [Hash] Edge object.
  # @param destination [Hash] Edge object.
  #
  # @return [Integer] Calculate days count for edge.
  def self.calculate_fastest_weight(prev, destination)
    trip_duration = (Date.parse(destination[:arrival_date]) - Date.parse(destination[:departure_date]) ).to_i
    if prev
      stop_duration = (Date.parse(destination[:departure_date]) - Date.parse(prev[:arrival_date]) ).to_i
      stop_duration + trip_duration
    else
      trip_duration
    end
  end

  # @param graph [Hash] Graph with all nodes for each port.
  # @param prev [Hash] Edge object.
  # @param origin [String] Origin port.
  #
  # @return [Array](Hash) Array of sailing objects with valid departure dates.
  def self.get_edges(graph, origin, prev)
    options = graph[origin]
    if prev
      options.filter { |current| Date.parse(current[:departure_date]) > Date.parse(prev[:arrival_date]) }
    else
      options
    end
  end
end

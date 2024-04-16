#!/usr/bin/env ruby
require 'json'
require_relative '../app/values/sailing'
require_relative '../lib/direct_routes'
require_relative '../lib/direct_or_indirect_routes'
require_relative '../lib/output_getaway'
require_relative '../lib/data_processor'
require_relative '../lib/data_reader'
require_relative '../lib/input_reader'

# @param origin [String] Origin port.
# @param destination [String] Destination port.
#
# @return [Array](Hash) Array of cheapest direct sailings
def cheapest_direct(origin, destination)
  edges = DataProcessor.prepare_edges
  result = DirectRoutes.find_cheapest(edges, origin, destination)
  OutputGetaway.show_result(result)
end

# @param origin [String] Origin port.
# @param destination [String] Destination port.
#
# @return [Array](Hash) Array of cheapest direct or indirect sailings
def cheapest_direct_or_indirect(origin, destination)
  edges = DataProcessor.prepare_edges
  result = DirectOrIndirectRoutes.find_cheapest(edges, origin, destination)
  OutputGetaway.show_result(result)
end

# @param origin [String] Origin port.
# @param destination [String] Destination port.
#
# @return [Array](Hash) Array of the fastest direct or indirect sailings
def fastest_direct_or_indirect(origin, destination)
  edges = DataProcessor.prepare_edges
  result = DirectOrIndirectRoutes.find_fastest(edges, origin, destination)
  OutputGetaway.show_result(result)
end

# support modules
origin, destination = InputReader.call
DataReader.call('response.json')

# main methods
cheapest_direct(origin, destination)
cheapest_direct_or_indirect(origin, destination)
fastest_direct_or_indirect(origin, destination)

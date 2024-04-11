#!/usr/bin/env ruby
require 'json'
require_relative '../app/values/sailing'
require_relative '../lib/direct_routes'
require_relative '../lib/direct_or_indirect_routes'
require_relative '../lib/output_getaway'
require_relative '../lib/data_processor'
require_relative '../lib/data_reader'
require_relative '../lib/input_reader'

def cheapest_direct(origin, destination)
  edges = DataProcessor.prepare_edges
  result = DirectRoutes.find_cheapest(edges, origin, destination)
  OutputGetaway.show_result(result)
end

def cheapest_direct_or_indirect(origin, destination)
  edges = DataProcessor.prepare_edges
  result = DirectOrIndirectRoutes.find_cheapest(edges, origin, destination)
  OutputGetaway.show_result(result)
end

def shortest_direct_or_indirect(origin, destination)
  edges = DataProcessor.prepare_edges
  result = DirectOrIndirectRoutes.find_shortest(edges, origin, destination)
  OutputGetaway.show_result(result)
end

# support modules
origin, destination = InputReader.call
DataReader.call('response.json')

# main methods
cheapest_direct(origin, destination)
cheapest_direct_or_indirect(origin, destination)

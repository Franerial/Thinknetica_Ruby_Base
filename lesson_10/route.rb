# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'exeption_classes'

class Route
  include InstanceCounter
  include Validation
  attr_reader :first_station, :last_station, :intermediate_stations

  validate :first_station, :type, Station
  validate :last_station, :type, Station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_stations = []
    register_instance
    validate!
  end

  def add_intermediative_station(station)
    intermediate_stations << station
  end

  def remove_intermediative_station(station)
    intermediate_stations.delete(station)
  end

  def stations_list
    [first_station] + intermediate_stations + [last_station]
  end
end

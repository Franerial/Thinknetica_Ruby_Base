require_relative "instance_counter"
require_relative "validation"
require_relative "exeption_classes"

class Route
  include InstanceCounter
  include Validation
  attr_reader :first_station, :last_station, :intermediate_stations

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

  def get_stations_list
    [first_station] + intermediate_stations + [last_station]
  end

  private

  def validate!
    raise RouteArgumentError, "Начальная станция указана некорректно!" if first_station.class != Station
    raise RouteArgumentError, "Конечная станция указана некорректно!" if last_station.class != Station
  end
end

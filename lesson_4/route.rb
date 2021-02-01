class Route
  attr_reader :first_station, :last_station, :intermediate_stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_stations = []
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
end

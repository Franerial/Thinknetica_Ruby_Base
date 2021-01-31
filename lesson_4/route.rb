class Route
    attr_reader :first_station, :last_station, :intermediative_stations

    def initialize (first_station, last_station)
        @first_station = first_station
        @last_station = last_station
        @intermediative_stations = []
    end

    def add_intermediative_station(station)
        self.intermediative_stations << station
    end

    def remove_intermediative_station(station)
        self.intermediative_stations.delete(station)
    end

    def get_stations_list
        [first_station] + intermediative_stations + [last_station]
    end
end

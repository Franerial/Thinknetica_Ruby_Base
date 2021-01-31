class Station
    attr_reader :trains, :name

    def initialize(name)
        @name = name
        @trains = []
    end

    def accept_train(train)
        self.trains << train
    end

    def send_train(train)
        self.trains.delete(train)
    end

    def get_cargo_trains
        self.trains.select {|train| train.type == :cargo}
    end

    def get_passenger_trains
        self.trains.select {|train| train.type == :passenger}
    end
end

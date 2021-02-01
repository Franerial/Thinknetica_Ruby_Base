class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def get_cargo_trains
    trains.select { |train| train.type == :cargo }
  end

  def get_passenger_trains
    trains.select { |train| train.type == :passenger }
  end
end

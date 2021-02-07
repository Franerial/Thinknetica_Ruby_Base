require_relative "instance_counter"

class Station
  include InstanceCounter
  attr_reader :trains, :name
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
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

  def self.all
    @@stations
  end
end

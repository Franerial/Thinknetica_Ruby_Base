require_relative "instance_counter"
require_relative "validation"

class Station
  include InstanceCounter
  include Validation
  attr_reader :trains, :name
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
    @name.capitalize!
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

  private

  def validate!
    raise ArgumentError, "Имя должно быть строкой!" if name.class != String
    raise ArgumentError, "Имя не может быть пустым!" if name.empty?
    raise ArgumentError, "Имя слишком короткое!" if name.length < 4
  end
end

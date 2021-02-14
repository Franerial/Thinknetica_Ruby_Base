# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'exeption_classes'

class Station
  include InstanceCounter
  include Validation
  attr_reader :trains, :name

  @stations = []

  class << self
    attr_reader :stations
  end

  def self.all
    stations
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.stations << self
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

  def cargo_trains
    trains.select { |train| train.type == :cargo }
  end

  def passenger_trains
    trains.select { |train| train.type == :passenger }
  end

  def iterate_through_trains
    yield(trains) if block_given?
  end

  private

  def validate!
    raise StationArgumentError, 'Имя должно быть строкой!' if name.class != String
    raise StationArgumentError, 'Имя не может быть пустым!' if name.empty?
    raise StationArgumentError, 'Имя слишком короткое!' if name.length < 4
  end
end

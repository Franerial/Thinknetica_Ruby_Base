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

  validate :name, :presence
  validate :name, :format, /^[а-яА-Яa-zA-Z]{3,8}-?[а-яА-Яa-zA-Z]{0,10}(-\d+)?$/
  validate :name, :type, String

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
end

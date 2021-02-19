# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacter'
require_relative 'validation'
require_relative 'exeption_classes'

class Train
  include Manufacter
  include InstanceCounter
  include Validation
  attr_reader :number, :type, :wagons_list, :current_speed, :current_station, :route

  @trains = []
  NUMBER_FORMAT = /^[\w\d][\w\d][\w\d]-?[\w\d][\w\d]$/.freeze

  private

  attr_writer :wagons_list, :current_speed, :current_station, :route

  public

  class << self
    attr_reader :trains
  end

  def self.find(number)
    trains.select { |train| train.number == number }
  end

  def initialize(number, type)
    @number = number
    @current_speed = 0
    @wagons_list = []
    @type = type
    self.class.trains << self
    register_instance
    self.class.validate :number, :presence
    self.class.validate :number, :format, NUMBER_FORMAT
    self.class.validate :number, :type, String
    validate!
    raise TrainArgumentError, 'Введён неверный тип поезда' unless %i[passenger cargo].include? type
  end

  def add_wagon(wagon)
    wagons_list << wagon if current_speed.zero? && (wagon.type == type)
  end

  def remove_wagon
    wagons_list.pop if current_speed.zero?
  end

  # rubocop:disable Lint/UselessAssignment
  def gain_speed(speed)
    current_speed += speed
  end

  def stop
    current_speed = 0
  end

  # rubocop:enable Lint/UselessAssignment
  def add_route(route)
    @route = route
    @current_station = route.first_station
  end

  def move_to_next_station
    current_station_index = route.stations_list.index(current_station)
    return unless (current_station_index + 1) != route.stations_list.size

    self.current_station = route.stations_list[current_station_index + 1]
    true
  end

  def move_to_previous_station
    current_station_index = route.stations_list.index(current_station)
    return unless current_station_index - 1 >= 0

    self.current_station = route.stations_list[current_station_index - 1]
    true
  end

  def iterate_through_wagons
    yield(wagons_list) if block_given?
  end
end

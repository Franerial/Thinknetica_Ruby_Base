require_relative "instance_counter"
require_relative "manufacter"
require_relative "validation"
require_relative "exeption_classes"

class Train
  include Manufacter
  include InstanceCounter
  include Validation
  attr_reader :number, :type, :wagons_list, :current_speed, :current_station, :route
  @@trains = []
  NUMBER_FORMAT = /^[\w\d][\w\d][\w\d]-?[\w\d][\w\d]$/

  private

  attr_writer :wagons_list, :current_speed, :current_station, :route #Значения этих атрибутов не должны изменяться в клиентской части, а только внутри класса

  public

  def initialize(number, type)
    @number = number
    @current_speed = 0
    @wagons_list = []
    @type = type
    @@trains << self
    register_instance
    validate!
  end

  def add_wagon(wagon)
    wagons_list << wagon if (current_speed == 0) && (wagon.type == type)
  end

  def remove_wagon
    wagons_list.pop if current_speed == 0
  end

  def gain_speed(speed)
    current_speed += speed
  end

  def stop
    current_speed = 0
  end

  def add_route(route)
    @route = route
    @current_station = route.first_station
  end

  def move_to_next_station
    current_station_index = route.get_stations_list.index(current_station)

    if (current_station_index + 1) != route.get_stations_list.size
      self.current_station = route.get_stations_list[current_station_index + 1]
      return true
    end
  end

  def move_to_previous_station
    current_station_index = route.get_stations_list.index(current_station)

    if current_station_index - 1 >= 0
      self.current_station = route.get_stations_list[current_station_index - 1]
      return true
    end
  end

  def self.find(number)
    @@trains.select { |train| train.number == number }
  end

  def iterate_through_wagons(&block)
    wagons_list.each_with_index(&block) if block_given?
  end

  private

  def validate!
    raise TrainArgumentError, "Номер должен быть строкой!" if number.class != String
    raise TrainArgumentError, "Введён неверный формат номера!" if number !~ NUMBER_FORMAT
    raise TrainArgumentError, "Введён неверный тип поезда" unless [:passenger, :cargo].include? type
  end
end

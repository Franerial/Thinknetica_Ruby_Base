require_relative "instance_counter"
require_relative "manufacter"

class Train
  include Manufacter
  include InstanceCounter
  attr_reader :number, :type, :wagons_list, :current_speed, :current_station, :route
  @@trains = []

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
end

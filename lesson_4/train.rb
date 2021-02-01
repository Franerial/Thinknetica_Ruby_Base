class Train
  attr_reader :number, :type
  attr_accessor :size, :current_speed, :current_station, :route

  def initialize(number, type, size)
    @number = number
    @type = type
    @size = size
    @current_speed = 0
  end

  def gain_speed(speed)
    current_speed += speed
  end

  def stop
    current_speed = 0
  end

  def add_wagon
    size += 1 if current_speed == 0
  end

  def remove_wagon
    size -= 1 if (current_speed == 0) && (size >= 1)
  end

  def add_route(route)
    @route = route
    @current_station = route.first_station
  end

  def move_to_next_station
    current_station_index = route.get_stations_list.index(current_station)

    if (current_station_index + 1) != route.get_stations_list.size
      current_station = route.get_stations_list[current_station_index + 1]
    else
      puts "Вы находитесь на последней станции. Дальнейшее перемещение вперёд невозможно!"
    end
  end

  def move_to_previous_station
    current_station_index = route.get_stations_list.index(current_station)

    if current_station_index - 1 >= 0
      current_station = route.get_stations_list[current_station_index - 1]
    else
      puts "Вы находитесь на первой станции. Дальнейшее перемещение назад невозможно!"
    end
  end
end

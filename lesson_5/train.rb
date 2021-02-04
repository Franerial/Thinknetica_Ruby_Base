class Train
  attr_reader :number, :type, :wagons_list, :current_speed, :current_station, :route

  private

  attr_writer :wagons_list, :current_speed, :current_station, :route #Значения этих атрибутов не должны изменяться в клиентской части, а только внутри класса

  public

  def initialize(number, type)
    @number = number
    @current_speed = 0
    @wagons_list = []
    @type = type
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
      puts "Поезд успешно перемещён на следующую станцию!"
    else
      puts "Вы находитесь на последней станции. Дальнейшее перемещение вперёд невозможно!"
    end
  end

  def move_to_previous_station
    current_station_index = route.get_stations_list.index(current_station)

    if current_station_index - 1 >= 0
      self.current_station = route.get_stations_list[current_station_index - 1]
      puts "Поезд успешно перемещён на предыдущую станцию!"
    else
      puts "Вы находитесь на первой станции. Дальнейшее перемещение назад невозможно!"
    end
  end
end

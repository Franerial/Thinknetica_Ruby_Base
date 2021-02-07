require_relative "station"
require_relative "route"
require_relative "train"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "wagon"
require_relative "passenger_wagon"
require_relative "cargo_wagon"

class Interface
  private

  attr_accessor :trains, :routes, :stations, :stop

  public

  MAIN_MENU = <<~here
    Пожалуйста, выберите действие
    1 : Создать станцию, поезд или маршрут
    2 : Произвести операции с созданными объектами
    3 : Получить текущие данные об объектах
    4 : Выход из программы
  here

  CREATION_MENU = <<~here
    1 : Создать станцию
    2 : Создать поезд
    3 : Создать маршрут
  here

  TRAIN_MANAGE_MENU = <<~here
    Выберите операцию
      1 : Добавить маршрут поезду
      2 : Добавить вагон поезду
      3 : Отцепить вагон от поезда
      4 : Переместить поезд вперёд
      5 : Переместить поезд назад
  here

  MANAGE_MENU = "1 : Управление поездами\n2 : Управление маршрутами"
  ROUTE_MANAGE_MENU = "1 : Добавление станции в маршрут\n2 : Удаление станции из маршрута"

  def initialize
    @stop = false
    @trains = []
    @routes = []
    @stations = []
  end

  def start
    loop do
      if stop
        puts "Программа завершена"
        break
      end
      puts MAIN_MENU
      action = gets.chomp.to_i
      perform_action(action)
    end
  end

  private

  def perform_action(action)
    case action
    when 1
      create_object
    when 2
      perform_object_operation
    when 3
      show_objects_info
    when 4
      self.stop = true
    end
  end

  def create_object
    puts CREATION_MENU
    action = gets.chomp.to_i
    case action
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    end
  end

  def perform_object_operation
    puts MANAGE_MENU
    action = gets.chomp.to_i
    case action
    when 1
      trains_manage
    when 2
      routes_manage
    end
  end

  def trains_manage
    puts "Список доступных поездов"
    trains.each_with_index { |train, index| puts "#{index} : #{train.number}" }
    puts "Выберите индекс поезда, над которым желайте выполнить операцию (начиная с 0)"
    train_index = gets.chomp.to_i
    puts TRAIN_MANAGE_MENU
    action = gets.chomp.to_i
    case action
    when 1
      add_route_to_train(train_index)
    when 2
      add_wagon_to_train(train_index)
    when 3
      remove_wagon_from_train(train_index)
    when 4
      move_train_to_next_station(train_index)
    when 5
      move_train_to_previous_station(train_index)
    end
  end

  def routes_manage
    puts "Список всех маршрутов:"
    routes.each_with_index { |route, index| puts "#{index} : #{route.get_stations_list.map { |station| station.name }}" }
    puts "Выберите индекс маршрута, над которым желайте произвести действие (начиная с 0)"
    route_index = gets.chomp.to_i
    puts ROUTE_MANAGE_MENU
    action = gets.chomp.to_i
    case action
    when 1
      add_station_to_route(route_index)
    when 2
      remove_station_from_route(route_index)
    end
  end

  def create_station
    puts "Пожалуйста, введите имя станции"
    station_name = gets.chomp
    stations << station = Station.new(station_name)
    puts "Станция была успешно добавлена!"
  end

  def create_train
    puts "Пожалуйста, введите номер поезда"
    train_number = gets.chomp.to_i
    puts "Пожалуйста, введите тип поезда (1 - грузовой 2 - пассажирский)"
    train_type = gets.chomp.to_i
    trains << PassengerTrain.new(train_number) if train_type == 2
    trains << CargoTrain.new(train_number) if train_type == 1
    puts "Поезд был успешно добавлен!"
  end

  def create_route
    puts "Список доступных станций:"
    stations.each_with_index { |station, index| p "#{index} : #{station.name}" }
    puts "Введите индекс начальной станции (начиная с нуля)"
    index_first = gets.chomp.to_i
    puts "Введите индекс конечной станции (начиная с нуля)"
    index_last = gets.chomp.to_i
    routes << Route.new(stations[index_first], stations[index_last])
    puts "Маршрут был успешно создан!"
  end

  def show_objects_info
    show_stations_info
    show_trains_info
    show_routes_info
  end

  def show_stations_info
    puts
    puts "Подробная информация по станциям:"
    puts
    stations.each_with_index do |station, index|
      puts "Станция номер #{index}"
      puts "Имя станции: #{station.name}"
      puts "Список грузовых поездов на станции: #{station.get_cargo_trains}" if !station.get_cargo_trains.empty?
      puts "Список пассажирских поездов на станции: #{station.get_passenger_trains}" if !station.get_passenger_trains.empty?
      puts
    end
  end

  def show_trains_info
    puts "Подробная информация по поездам:"
    puts
    trains.each_with_index do |train, index|
      puts "Поезд номер #{index}"
      puts "Регистрационный номер поезда: #{train.number}"
      puts "Тип поезда: #{train.type}"
      puts "Текущая скорость поезда: #{train.current_speed}"
      puts "Текущая станция поезда: #{train.current_station.name}" if !train.current_station.nil?
      puts "Текущий маршрут поезда: #{train.route.get_stations_list.map { |station| station.name }}" if !train.route.nil?
      puts "Текущий список вагонов поезда: #{train.wagons_list}" if !train.wagons_list.empty?
      puts
    end
  end

  def show_routes_info
    puts "Подробная информация по маршрутам:"
    puts
    routes.each_with_index do |route, index|
      puts "Маршрут номер #{index}"
      puts "Начальная станция маршрута: #{route.first_station.name}"
      puts "Конечная станция маршрута: #{route.last_station.name}"
      puts "Все станции маршрута по порядку: #{route.get_stations_list.map { |station| station.name }}"
      puts
    end
  end

  def add_route_to_train(train_index)
    puts "Список доступных маршрутов:"
    routes.each_with_index { |route, index| puts "#{index} : #{route.get_stations_list.map { |station| station.name }}" }
    puts "Выберите индекс маршрута, который желайте добавить (начиная с 0)"
    route_index = gets.chomp.to_i
    trains[train_index].add_route(routes[route_index])
    puts "Маршрут успешно добавлен!"
  end

  def add_wagon_to_train(train_index)
    wagon = CargoWagon.new(CargoWagon::TYPE) if trains[train_index].type == :cargo
    wagon = PassengerWagon.new(PassengerWagon::TYPE) if trains[train_index].type == :passenger
    trains[train_index].add_wagon(wagon)
    puts "Вагон успешно добавлен!"
  end

  def remove_wagon_from_train(train_index)
    trains[train_index].remove_wagon
    puts "Вагон успешно отсоединён!"
  end

  def add_station_to_route(route_index)
    puts "Список всех доступных станций:"
    stations.each_with_index { |station, index| puts "#{index} : #{station.name}" }
    puts "Введите индекс станции, который желайте добавить в маршрут"
    station_index = gets.chomp.to_i
    routes[route_index].add_intermediative_station(stations[station_index])
    puts "Станция успешно добавлена в маршрут!"
  end

  def remove_station_from_route(route_index)
    puts "Список всех доступных станций в маршруте:"
    routes[route_index].get_stations_list.each_with_index { |station, index| puts "#{index} : #{station.name}" }
    puts "Введите индекс станции, который желайте удалить из маршрута (начиная с 0)"
    station_index = gets.chomp.to_i
    station = routes[route_index].get_stations_list[station_index]
    routes[route_index].remove_intermediative_station(station)
    puts "Станция успешно удалена!"
  end

  def move_train_to_next_station(train_index)
    if trains[train_index].move_to_next_station
      puts "Поезд успешно перемещён на следующую станцию!"
    else
      puts "Вы находитесь на последней станции. Дальнейшее перемещение вперёд невозможно!"
    end
  end

  def move_train_to_previous_station(train_index)
    if trains[train_index].move_to_previous_station
      puts "Поезд успешно перемещён на предыдущую станцию!"
    else
      puts "Вы находитесь на первой станции. Дальнейшее перемещение назад невозможно!"
    end
  end
end

interface = Interface.new
interface.start

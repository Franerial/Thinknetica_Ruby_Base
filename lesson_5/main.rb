require_relative "station"
require_relative "route"
require_relative "train"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "wagon"
require_relative "passenger_wagon"
require_relative "cargo_wagon"

@trains = []
@routes = []
@stations = []

loop do
  puts "Пожалуйста, выберите действие"
  puts "1 : Создать станцию, поезд или маршрут"
  puts "2 : Произвести операции с созданными объектами"
  puts "3 : Получить текущие данные об объектах"
  puts "4 : Выход из программы"
  action = gets.chomp.to_i
  case action
  when 1
    puts "1 : Создать станцию"
    puts "2 : Создать поезд"
    puts "3 : Создать маршрут"
    action = gets.chomp.to_i
    case action
    when 1
      puts "Пожалуйста, введите имя станции"
      station_name = gets.chomp
      @stations << station = Station.new(station_name)
      puts "Станция была успешно добавлена!"
    when 2
      puts "Пожалуйста, введите номер поезда"
      train_number = gets.chomp.to_i
      puts "Пожалуйста, введите тип поезда (1 - грузовой 2 - пассажирский)"
      train_type = gets.chomp.to_i
      @trains << PassengerTrain.new(train_number) if train_type == 2
      @trains << CargoTrain.new(train_number) if train_type == 1
      puts "Поезд был успешно добавлен!"
    when 3
      puts "Список доступных станций:"
      @stations.each_with_index { |station, index| p "#{index} : #{station.name}" }
      puts "Введите индекс начальной станции (начиная с нуля)"
      index_first = gets.chomp.to_i
      puts "Введите индекс конечной станции (начиная с нуля)"
      index_last = gets.chomp.to_i
      @routes << Route.new(@stations[index_first], @stations[index_last])
      puts "Маршрут был успешно создан!"
    end
  when 3
    puts
    puts "Подробная информация по станциям:"
    puts
    @stations.each_with_index do |station, index|
      puts "Станция номер #{index}"
      puts "Имя станции: #{station.name}"
      puts "Список грузовых поездов на станции: #{station.get_cargo_trains}" if !station.get_cargo_trains.empty?
      puts "Список пассажирских поездов на станции: #{station.get_passenger_trains}" if !station.get_passenger_trains.empty?
      puts
    end
    puts "Подробная информация по поездам:"
    puts
    @trains.each_with_index do |train, index|
      puts "Поезд номер #{index}"
      puts "Регистрационный номер поезда: #{train.number}"
      puts "Тип поезда: #{train.type}"
      puts "Текущая скорость поезда: #{train.current_speed}"
      puts "Текущая станция поезда: #{train.current_station.name}" if !train.current_station.nil?
      puts "Текущий маршрут поезда: #{train.route.get_stations_list.map { |station| station.name }}" if !train.route.nil?
      puts "Текущий список вагонов поезда: #{train.wagons_list}" if !train.wagons_list.empty?
      puts
    end
    puts "Подробная информация по маршрутам:"
    puts
    @routes.each_with_index do |route, index|
      puts "Маршрут номер #{index}"
      puts "Начальная станция маршрута: #{route.first_station.name}"
      puts "Конечная станция маршрута: #{route.last_station.name}"
      puts "Все станции маршрута по порядку: #{route.get_stations_list.map { |station| station.name }}"
      puts
    end
  when 4
    puts "Работа программы завершена"
    break
  when 2
    puts "1 : Управление поездами"
    puts "2 : Управление маршрутами"
    action = gets.chomp.to_i
    case action
    when 1
      puts "Список доступных поездов"
      @trains.each_with_index { |train, index| puts "#{index} : #{train.number}" }
      puts "Выберите индекс поезда, над которым желайте выполнить операцию (начиная с 0)"
      train_index = gets.chomp.to_i
      puts "Выберите операцию"
      puts "1 : Добавить маршрут поезду"
      puts "2 : Добавить вагон поезду"
      puts "3 : Отцепить вагон от поезда"
      puts "4 : Переместить поезд вперёд"
      puts "5 : Переместить поезд назад"
      action = gets.chomp.to_i
      case action
      when 1
        puts "Список доступных маршрутов:"
        @routes.each_with_index { |route, index| puts "#{index} : #{route.get_stations_list.map { |station| station.name }}" }
        puts "Выберите индекс маршрута, который желайте добавить (начиная с 0)"
        route_index = gets.chomp.to_i
        @trains[train_index].add_route(@routes[route_index])
        puts "Маршрут успешно добавлен!"
      when 2
        wagon = CargoWagon.new if @trains[train_index].type == :cargo
        wagon = PassengerWagon.new if @trains[train_index].type == :passenger
        @trains[train_index].add_wagon(wagon)
        puts "Вагон успешно добавлен!"
      when 3
        @trains[train_index].remove_wagon
        puts "Вагон успешно отсоединён!"
      when 4
        @trains[train_index].move_to_next_station
      when 5
        @trains[train_index].move_to_previous_station
      end
    when 2
      puts "Список всех маршрутов:"
      @routes.each_with_index { |route, index| puts "#{index} : #{route.get_stations_list.map { |station| station.name }}" }
      puts "Выберите индекс маршрута, над которым желайте произвести действие (начиная с 0)"
      route_index = gets.chomp.to_i
      puts "1 : Добавление станции в маршрут"
      puts "2 : Удаление станции из маршрута"
      action = gets.chomp.to_i
      case action
      when 1
        puts "Список всех доступных станций:"
        @stations.each_with_index { |station, index| puts "#{index} : #{station.name}" }
        puts "Введите индекс станции, который желайте добавить в маршрут"
        station_index = gets.chomp.to_i
        @routes[route_index].add_intermediative_station(@stations[station_index])
        puts "Станция успешно добавлена в маршрут!"
      when 2
        puts "Список всех доступных станций в маршруте:"
        @routes[route_index].get_stations_list.each_with_index { |station, index| puts "#{index} : #{station.name}" }
        puts "Введите индекс станции, который желайте удалить из маршрута (начиная с 0)"
        station_index = gets.chomp.to_i
        station = @routes[route_index].get_stations_list[station_index]
        @routes[route_index].remove_intermediative_station(station)
        puts "Станция успешно удалена!"
      end
    end
  end
end

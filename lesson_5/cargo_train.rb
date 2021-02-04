class CargoTrain < Train
  TYPE = :cargo

  def initialize(number)
    super(number, TYPE)
  end

  def add_wagon(wagon)
    wagons_list << wagon if (current_speed == 0) && (wagon.class == CargoWagon)
  end

  def remove_wagon
    wagons_list.pop if current_speed == 0
  end
end

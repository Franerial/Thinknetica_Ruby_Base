require_relative "exeption_classes"

class CargoWagon < Wagon
  TYPE = :cargo
  attr_reader :total_capacity, :occupied_capacity, :free_capacity

  private

  attr_writer :occupied_capacity, :free_capacity

  public

  def initialize(total_capacity)
    super(TYPE)
    @total_capacity = total_capacity
    @occupied_capacity = 0
    @free_capacity = total_capacity
    validate!
  end

  def add_capacity(capacity)
    self.occupied_capacity += capacity
    self.free_capacity = total_capacity - occupied_capacity
    raise CargoWagonArgumentError, "Вагон полный!" if occupied_capacity >= total_capacity
  end

  private

  def validate!
    super
    raise CargoWagonArgumentError, "Объём должен быть целым числом!" if total_capacity.class != Integer
    raise CargoWagonArgumentError, "Объём не может быть отрицательным!" if total_capacity <= 0
  end
end

# frozen_string_literal: true

require_relative 'exeption_classes'

class CargoWagon < Wagon
  TYPE = :cargo
  attr_reader :total_capacity, :occupied_capacity, :free_capacity

  validate :total_capacity, :type, Integer

  private

  attr_writer :occupied_capacity, :free_capacity

  public

  def initialize(total_capacity)
    super(TYPE)
    @total_capacity = total_capacity
    @occupied_capacity = 0
    @free_capacity = total_capacity
    validate!
    raise CargoWagonArgumentError, 'Объём не может быть отрицательным!' if total_capacity <= 0
  end

  def add_capacity(capacity)
    self.occupied_capacity += capacity
    self.free_capacity = total_capacity - occupied_capacity
    raise CargoWagonArgumentError, 'Вагон полный!' if occupied_capacity >= total_capacity
  end
end

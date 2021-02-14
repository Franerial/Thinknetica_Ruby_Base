# frozen_string_literal: true

class CargoTrain < Train
  TYPE = :cargo
  @trains = []

  def initialize(number)
    super(number, TYPE)
  end
end

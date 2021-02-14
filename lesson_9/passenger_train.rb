# frozen_string_literal: true

class PassengerTrain < Train
  TYPE = :passenger
  @trains = []

  def initialize(number)
    super(number, TYPE)
  end
end

require_relative "exeption_classes"

class PassengerWagon < Wagon
  TYPE = :passenger
  attr_reader :total_seats_number, :occupied_seats_number, :free_seats_number

  private

  attr_writer :occupied_seats_number, :free_seats_number

  public

  def initialize(total_seats_number)
    super(TYPE)
    @total_seats_number = total_seats_number
    @occupied_seats_number = 0
    @free_seats_number = total_seats_number
    validate!
  end

  def take_seat
    self.occupied_seats_number += 1
    self.free_seats_number = total_seats_number - occupied_seats_number
    raise PassengerWagonArgumentError, "Все места заняты!" if occupied_seats_number == total_seats_number
  end

  private

  def validate!
    super
    raise PassengerWagonArgumentError, "Кол-во мест должно быть целым числом!" if total_seats_number.class != Integer
    raise PassengerWagonArgumentError, "Кол-во мест не может быть отрицательным!" if total_seats_number <= 0
  end
end

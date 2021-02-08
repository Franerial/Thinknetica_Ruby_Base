require_relative "manufacter"
require_relative "validation"

class Wagon
  include Manufacter
  include Validation
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  private

  def validate!
    raise ArgumentError, "Введён неверный тип вагона" unless [:passenger, :cargo].include? type
  end
end

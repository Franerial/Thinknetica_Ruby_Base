require_relative "manufacter"

class Wagon
  include Manufacter
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

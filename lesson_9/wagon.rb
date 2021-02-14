# frozen_string_literal: true

require_relative 'manufacter'
require_relative 'validation'
require_relative 'exeption_classes'

class Wagon
  include Manufacter
  include Validation
  attr_reader :type

  def initialize(type)
    @type = type
  end

  private

  def validate!
    raise WagonArgumentError, 'Введён неверный тип вагона' unless %i[passenger cargo].include? type
  end
end

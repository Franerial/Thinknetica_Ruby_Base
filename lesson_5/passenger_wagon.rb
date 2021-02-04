class PassengerWagon < Wagon
  TYPE = :passenger

  def initialize
    super(TYPE)
  end
end

class Station
  attr_reader :name, :zone
  
  def initialize(information)
    @name = information[:name]
    @zone = information[:zone]
  end
end
class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
    @history = []
    @in_use = nil
    @fare = 0
  end

  def begin(entry_station)
    @entry_station = entry_station
  end 
  
  def finish(exit_station)
    @exit_station = exit_station
  end

  def history
    current_journey = { entry_station: @entry_station, exit_station: @exit_station}
    @history.push(current_journey)
  end
  
  def fare
    @fare = completed? ? MINIMUM_FARE : PENALTY_FARE
  end  

  #private

  def completed?
    if @entry_station != nil && @exit_station != nil
      @in_use = true
    else 
      @in_use = false
    end
  end
    
end
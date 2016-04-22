

class Oystercard
	MAXIMUM_BALANCE = 90

	attr_reader :balance, :starting_station, :ending_station, :history, :journey, :current_journey

  def initialize
    @balance = 0
		@starting_station = nil
    @ending_station = nil
	end

  def top_up(money)
  	raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if money + balance > MAXIMUM_BALANCE
		@balance += (money)
  end

  def touch_in(starting_station)
    raise "Insufficient balance for journey" if balance < 1
    current_journey
    if @other_journey
      deduct
    else
       @journey.begin(starting_station)
    end  
        # if @current_journey != nil
    #   deduct(@current_journey.fare) unless @current_journey.completed?
    #@history << { starting_station: @current_journey.entry_station }
  end

  def touch_out(ending_station)
    #current_journey
    #@ending_station = ending_station
    @journey.finish(ending_station)
    deduct 
  end 

  def current_journey
      if @journey == nil
        @journey = Journey.new
      else
        @journey = @other_journey
      end    
  end

  def station_history
    @journey.history
  end  

  #private

  attr_reader :status

  def deduct
    fare = @journey.fare
    @balance -= fare
  end

end
 
    # if @current_journey == nil
    #   @current_journey = @journey.new(entry_station: nil)

    #   journey = @current_journey.finish(ending_station)
    #   @history << {exit_station: journey.exit_station}
     
    # if @current_journey != nil
    #   journey = @current_journey.finish(ending_station)
    #   @history << {exit_station: journey.exit_station}
    # end

  # def touch_out(ending_station)
  #   #touch_in(nil) unless @current_journey
  #   if @current_journey == nil
  #     @current_journey = @journey.new
  #     journey = @current_journey.finish(ending_station)
  #     @history << {exit_station: journey.exit_station}
  #     return deduct(journey.fare)
  #   end

  #   if @current_journey != nil
  #     if @history.last[:entry_station] == nil
  #     deduct(@current_journey.fare) 
  #     end
  #   end 

  #   @current_journey = @journey.new
  #   if @history.last[:entry_station] == nil
  #     deduct(journey.fare)
  #   end
		# journey = @current_journey.finish(ending_station)
  #   @history.last.store(:exit_station, journey.exit_station)#history = [{staring_station => "west"}]
  #   deduct(journey.fare)


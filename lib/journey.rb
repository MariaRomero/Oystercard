class Journey
	MINIMUM_FARE = 1
	PENALTY_FARE = 6

	attr_reader :entry_station, :exit_station

	def start(station)
		@entry_station = station
	end	

	def finish(station)
		@exit_station = station
	end

	def completed?
		!!(entry_station && exit_station)
	end

	def fare
		completed? ? MINIMUM_FARE : PENALTY_FARE
	end	
		
end	
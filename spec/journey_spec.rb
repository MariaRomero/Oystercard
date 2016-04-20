require "journey"

describe Journey do 
	subject(:journey) {described_class.new}
	let(:station) {double :station }

	describe "initialization" do
		it "journey should not be completed" do
			expect(journey).not_to be_completed
		end	
	end	

	describe "#start" do
		it "starts a journey" do
			journey.start(station)
			expect(journey.entry_station).to eq station	
			#expect(journey).to respond_to(:start).with(1).argument
		end	
	end

	describe "#finish" do
		it "finishes a journey" do
			journey.finish(station)
			expect(journey.exit_station).to eq station
		end	
	end

	describe "#fare" do
		it "calculates the fare for the journey" do
			journey.start(station)
			journey.finish(station)
			expect(journey.fare).to eq described_class::MINIMUM_FARE
		end	

	end	


end
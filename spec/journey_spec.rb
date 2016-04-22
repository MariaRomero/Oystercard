require "journey"

describe Journey do 
  subject(:journey) {described_class.new(entry_station: :station) }
  let(:station) {double :station }

  describe "#initialization" do
    it 'is created with an entry station' do
      expect(journey.entry_station).to eq ({entry_station: :station})
    end
    it "journey should not be completed" do
      expect(journey).not_to be_completed
    end  
    it 'has a penalty fare by default' do
    	expect(journey.fare).to eq Journey::PENALTY_FARE
  	end
  end  

  describe "#finish" do
    it "returns itself when exiting a journey" do
    	expect(journey.finish(station)).to eq(journey)
  	end
  	it "charges the penalty if journey is not finished" do
  		expect(journey.fare).to eq Journey::PENALTY_FARE
  	end	
  end

  describe "#fare" do
    it "calculates the fare for the journey" do
      journey.finish(station)
      expect(journey.fare).to eq described_class::MINIMUM_FARE
    end  
  end  

end

# context 'when in journey' do
#     before(:each) do
#       oystercard.top_up(card_max)
#       oystercard.touch_in(starting_station)
#     end
#     it "prevents use if oystercard doesn't have minimum balance" do 
#       oystercard.top_up(card_max)
#       expect { oystercard.touch_in(starting_station) }.to raise_error "Insufficient balance for journey"
#     end
#     it "touches in recognizes a starting station" do
#   		expect(oystercard).to be_in_journey
#   	end
#     it "remembers the entry station" do
#       expect(oystercard.starting_station).to eq starting_station
#     end
#   end
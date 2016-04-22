require 'oystercard'

describe Oystercard do

	subject(:oystercard){ described_class.new(journey) }
  let (:card_max) { Oystercard::MAXIMUM_BALANCE }
  let (:min_fare) { Oystercard::MINIMUM_FARE }
  let (:starting_station) { double :station }
  let (:ending_station) { double :station }
  let (:journey) {double :journey, entry_station: :station, exit_station: :exit_station, fare: 1}

  describe "#initialization" do
  	it 'has a default balance of 0 on initialization' do
      expect(subject.balance).to eq 0
	  end
    it 'has an empty history when card is issued' do
      expect(oystercard.history).to be_empty
    end
  end

  describe '#top_up' do
    it 'tops up the balance' do
      expect{ oystercard.top_up(card_max) }.to change{oystercard.balance}.by card_max
	  end
    it "raises an error when the maximum balance is exceeded" do
		  oystercard.top_up(card_max)
		  expect{ oystercard.top_up(1) }.to raise_error "maximum balance of #{card_max} exceeded"
    end
  end

  describe "#touch_in" do
    it "prevents use if oystercard doesn't have minimum balance" do 
      expect{ oystercard.touch_in(starting_station) }.to raise_error "Insufficient balance for journey"
    end
    it "touches in and stores an entry station" do
      oystercard.top_up(card_max)
      journey.stub(:new).and_return(journey)
      oystercard.touch_in(:station)
      expect(oystercard.history[0][:starting_station]).to eq :station
    end
  end

  context 'when journey is complete' do
    before do
      oystercard.top_up(card_max)
      journey.stub(:new).and_return(journey)
      oystercard.touch_in(:station)
      journey.stub(:finish).and_return(journey)
      oystercard.touch_out(:exit_station)
    end
    it "touches out and saves journey" do
      expect(oystercard.history[0][:exit_station]).to eq :exit_station
    end
    it "deducts the correct journey fare from my card when touching out" do
      expect(oystercard.balance).to eq (card_max - 1)
    end
    it "clears the starting station for the next journey" do #remember to update for multiple journeys
      oystercard.touch_out(ending_station)
      expect(oystercard.starting_station).to be nil
    end
  end
end

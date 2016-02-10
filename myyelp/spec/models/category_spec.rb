require 'spec_helper'

describe Category do
  it { is_expected.to have_many(:businesses) }
  it { is_expected.to validate_presence_of(:name) }

  describe "#recent_businesses" do
    before do 
      @food = Fabricate(:category, name: "Food")
      @drink = Fabricate(:category, name: "Drink")
    end

    it "returns only businesses in specified category" do
      food = Fabricate(:category, id: 1, name: "Food")
      Fabricate.times(3, :business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 7.day.ago)
      drinks = Fabricate(:category, id: 2, name: "Drinks")
      Fabricate.times(3, :business, name: "Motorino", description: "Rustic pizza", category: @drink, created_at: 7.day.ago)
      expect(@food.recent_businesses.count).to eq(3)
    end

    it "returns only recent businesses in reverse chronological order" do
      motorino1 = Fabricate(:business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 7.day.ago)
      motorino2 = Fabricate(:business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 5.day.ago)
      motorino3 = Fabricate(:business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 3.day.ago)
      expect(@food.recent_businesses).to eq([motorino3, motorino2, motorino1])
    end
      
    it "returns only 3 most recent businesses in revers chrnological order" do
      motorino1 = Fabricate(:business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 7.day.ago)
      motorino2 = Fabricate(:business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 5.day.ago)
      motorino3 = Fabricate(:business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 3.day.ago)
      motorino4 = Fabricate(:business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 2.day.ago)
      motorino5 = Fabricate(:business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 1.day.ago)
      expect(@food.recent_businesses).to eq([motorino5, motorino4, motorino3])
    end
    it "returns all businesses if less than 3 businesses in the specified category" do
      motorino1 = Fabricate(:business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 7.day.ago)
      motorino2 = Fabricate(:business, name: "Motorino", description: "Rustic pizza", category: @food, created_at: 5.day.ago)
      expect(@food.recent_businesses).to eq([motorino2, motorino1])
    end

    it "returns an empty array if no businesses in category" do 
      expect(@food.recent_businesses).to eq([])
    end
  end
end
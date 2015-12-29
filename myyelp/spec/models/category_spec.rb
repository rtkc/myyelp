require 'spec_helper'

describe Category do
  it { is_expected.to have_many(:businesses) }
  it { is_expected.to validate_presence_of(:name) }

  describe "#recent_businesses" do
    it "returns only businesses in specified category" do
      food = Category.create(name: "Food")
      3.times { Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 7.day.ago)}
      drinks = Category.create(name: "Drinks")
      3.times { Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 7.day.ago)}
      expect(food.recent_businesses.count).to eq(3)
    end

    it "returns only recent businesses in reverse chronological order" do
      food = Category.create(name: "Food")
      motorino1 = Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 7.day.ago)
      motorino2 = Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 5.day.ago)
      motorino3 = Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 3.day.ago)
      expect(food.recent_businesses).to eq([motorino3, motorino2, motorino1])
    end
      
    it "returns only 3 most recent businesses in revers chrnological order" do
      food = Category.create(name: "Food")
      motorino1 = Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 7.day.ago)
      motorino2 = Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 5.day.ago)
      motorino3 = Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 3.day.ago)
      motorino4 = Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 2.day.ago)
      motorino5 = Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 1.day.ago)
      expect(food.recent_businesses).to eq([motorino5, motorino4, motorino3])
    end
    it "returns all businesses if less than 3 businesses in the specified category" do
      food = Category.create(name: "Food")
      motorino1 = Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 7.day.ago)
      motorino2 = Business.create(name: "Motorino", description: "Rustic pizza", category: food, created_at: 5.day.ago)
      expect(food.recent_businesses).to eq([motorino2, motorino1])
    end

    it "returns an empty array if no businesses in category" do
      food = Category.create(name: "Food")
      expect(food.recent_businesses).to eq([])
    end
  end
end
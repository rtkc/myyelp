require 'spec_helper'

feature 'add business listing' do
  before { food = Fabricate(:category, name: 'Food') }
  scenario 'User adds a new business listing' do 
    sign_in
    add_business_listing
    expect_new_business_listing
  end

  def add_business_listing
    visit home_path
    click_link "Add new business"
    fill_in "business[name]", with: 'KFC'
    fill_in "business[description]", with: 'Fried chicken fast food'
    select("Food", from: 'Category')
    select('Hong Kong', from: 'Country')
    click_button "Create new entry"
  end

  def expect_new_business_listing
    expect(Business.count).to eq(1)
  end
end 
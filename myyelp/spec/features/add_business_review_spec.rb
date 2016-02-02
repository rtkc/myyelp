require 'spec_helper'

feature 'create business review' do
  scenario 'User reviews a listed business' do
    food = Fabricate(:category)
    kfc = Fabricate(:business, category_id: food.id)
    sign_in
    select_a_business(kfc)
    review_business
    expect_new_review_for_associated_business
  end

  def select_a_business(business)
    visit home_path
    click_link "#{business.name}"
    expect(page).to have_content(business.description)
  end

  def review_business
    select("5", from: "Rate this video")
    fill_in "review[review]", with: "This business is awesome"
    click_button "Submit"
  end

  def expect_new_review_for_associated_business
    expect(Business.first.reviews.count).to eq(1)
  end
end
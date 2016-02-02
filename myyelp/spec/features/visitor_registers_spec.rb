require 'spec_helper'

feature 'User registers' do
  scenario "Unregistered user registers" do
    register
    expect_user_registered
  end

  def register
    visit root_path
    click_link "Sign Up Now!"
    fill_in "user[email]", with: 'leo@email.com'
    fill_in "user[password]", with: 'password'
    fill_in "user[full_name]", with: 'leo dicap'
    click_button "Sign up"
  end

  def expect_user_registered
    expect(User.count).to eq(1)
  end
end
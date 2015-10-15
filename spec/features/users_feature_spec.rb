require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end

    it "must be logged in to create restaurant" do
      visit('/')
      click_link('Add a restaurant')
      expect(page).not_to have_button('Create Restaurant')
    end
  end

  context "user signed in on the homepage" do

    before do
      user = build :user
      sign_up(user)
    end

    it "can edit restaurant which they created" do
      visit('/')

      click_link('Add a restaurant')
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_link 'Edit KFC'
    end

    it "cannot edit restaurants which it did not create" do
      visit('/')
      click_link('Add a restaurant')
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Sign out'
      user = build :user2
      sign_up(user)
      expect(page).not_to have_link('Edit KFC')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

  end
end

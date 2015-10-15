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

    it "can edit restaurant which they created" do
      user = create :user
      sign_in(user)
      visit('/')
      click_link('Add a restaurant')
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_link 'Edit KFC'
    end

    it "cannot edit restaurants which it did not create" do
      # visit('/')
      # click_link('Sign up')
      # fill_in('Email', with: 'example@example.com')
      # fill_in('Password', with: 'testtest')
      # fill_in('Password confirmation', with: 'testtest')
      # click_button('Sign up')
      user = build :user2
      sign_up(user)
      visit('/')
      expect(page).not_to have_link('Edit KFC')
    end

    it "should see 'sign out' link" do
      user = build :user
      sign_up(user)
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      user = create :user
      sign_in(user)
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

  end
end

require 'spec_helper'

feature 'user signs up' do
	scenario 'with valid email and password' do
		sign_up_with 'John Smith', 'me@example.com', 'password'
		expect(page).to have_content('John Smith')
	end
	scenario 'with invalid email' do
		sign_up_with 'John Smith', 'foo.bar.com', 'password'
		expect(page).to have_content('Email is invalid')
	end

	def sign_up_with(name, email, password)
		visit new_user_path
		fill_in 'Name', with: name
		fill_in 'Email', with: email
		fill_in 'Password', with: password
		fill_in 'Confirmation', with: password
		click_button 'Create my account'
	end

end




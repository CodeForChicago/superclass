RSpec.configure do |c|
	  c.include Helpers::SessionsHelper
end

require 'spec_helper'
# require "pry"
feature "Feedback Page" do
	
	scenario "User omitted email" do
		visit feedback_path
		fill_in 'Name', with: 'wayne rooney'
		fill_in 'Message', with: 'manchester is red'
		expect{
		click_button 'Send message'
		}.to change{ActionMailer::Base.deliveries.count}.by(0)
		expect(page).to have_field('Name', with: 'wayne rooney')
		expect(page).to have_field('Message', with: 'manchester is red')
	end
		
	scenario "User omitted name" do
		visit feedback_path
		fill_in 'Email', with: 'manchesterisred@cfc.com'
		fill_in 'Message', with: 'manchester is red'
		expect{
		click_button 'Send message'
		}.to change{ActionMailer::Base.deliveries.count}.by(0)
		expect(page).to have_field('Email', with: 'manchesterisred@cfc.com')
		expect(page).to have_field('Message', with: 'manchester is red')
	end
	
	scenario "User omitted message" do
		visit feedback_path
		fill_in 'Name', with: 'wayne rooney'
		fill_in 'Email', with: 'manchesterisred@cfc.com'
		expect{
		click_button 'Send message'
		}.to change{ActionMailer::Base.deliveries.count}.by(0)
		expect(page).to have_field('Name', with: 'wayne rooney')
		# expect(page).to have_field('Email', with: 'manchesterisred@cfc.com')
	end

	scenario "user is not signed in" do
		visit feedback_path
		fill_in 'Email', with: 'manchesterisred@cfc.com'
		fill_in 'Name', with: 'wayne rooney'
		fill_in 'Message', with: 'manchester is red'
		expect{
		click_button 'Send message'
		}.to change{ActionMailer::Base.deliveries.count}.by(1)
		expect(page).to have_content('We appreciate your feedback! We will review your
                            message and try to improve our website soon.', count: 1)
	end

	scenario "user is signed in" do
    visit new_user_session_path
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    click_button 'Log in'
    expect(page).to have_content I18n.t "devise.sessions.signed_in"
    
		visit feedback_path
		fill_in 'Message', with: 'manchester is red'
		expect{
		click_button 'Send message'
		}.to change{ActionMailer::Base.deliveries.count}.by(1)
		expect(page).to have_content('We appreciate your feedback! We will review your
                            message and try to improve our website soon.', count: 1)

	end

end

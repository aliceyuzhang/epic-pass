require 'spec_helper'

# TODO: change the following constants
RESORT_LOCATION = 'Northstar'.freeze
DATES_OF_THE_MONTH = [13, 14].freeze
USERNAME = 'youremail@gmail.com'.freeze
PASSWORD = 'yourpassword'.freeze

describe "Epic Pass", type: :feature do
  DATES_OF_THE_MONTH.each do |date|
    it "booking the dates" do
      visit '/account/login.aspx'
      sleep 1
      expect(page).to have_content('Password')
      fill_in 'txtUserName_3', with: USERNAME
      fill_in 'txtPassword_3', with: PASSWORD
      sleep 1
      find('.accountLogin__cta').click
      sleep 2

      visit '/plan-your-trip/lift-access/reservations.aspx'
      sleep 1
      select RESORT_LOCATION, from: 'PassHolderReservationComponent_Resort_Selection'
      click_button 'Check Availability'
      sleep 1
      all('button.passholder_reservations__calendar__day')[date-1].click
      sleep 1
      expect(page).to have_css '.passholder_reservations__assign_passholder_modal'
      page.execute_script("$('.passholder_reservations__assign_passholder_modal__label label input').click()")
      click_button 'Assign Pass Holders'
      sleep 1
      page.execute_script("$('input#terms-accepted').click()")
      click_button 'Complete Reservation'
      puts "***********************************************\n"
      puts "SUCCESSFULLY RESERVED #{date}"
      puts "\n***********************************************"
      sleep 1
    end
    sleep 1
  end
end

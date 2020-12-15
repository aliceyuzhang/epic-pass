require 'spec_helper'

# TODO: change the following constants
RESORT_LOCATION = 'Park City'.freeze
NOT_GOING_RESORT_LOCATION = 'Northstar'.freeze
DATES_OF_THE_MONTH = [20].freeze
USERNAME = 'username_or_email'.freeze
PASSWORD = 'password'.freeze

sleep_duration = 0.3

describe "Epic Pass", type: :feature do
  DATES_OF_THE_MONTH.each do |date|
    it "booking the dates" do
      visit '/account/login.aspx'
      sleep sleep_duration * 3
      expect(page).to have_content('Password')
      fill_in 'txtUserName_3', with: USERNAME
      fill_in 'txtPassword_3', with: PASSWORD
      sleep sleep_duration * 3
      find('.accountLogin__cta').click
      sleep sleep_duration * 6
      visit '/plan-your-trip/lift-access/reservations.aspx'
      sleep sleep_duration * 3

      while true
        begin
          select RESORT_LOCATION, from: 'PassHolderReservationComponent_Resort_Selection'
          click_button 'Check Availability'
          sleep sleep_duration
          all('button.passholder_reservations__calendar__day')[date-1].click
          sleep sleep_duration
          if find('.passholder_reservations__assign_passholder_modal')
            break
          end
        rescue
          select NOT_GOING_RESORT_LOCATION, from: 'PassHolderReservationComponent_Resort_Selection'
          click_button 'Check Availability'
          sleep sleep_duration
        end
      end
      
      page.execute_script("$('.passholder_reservations__assign_passholder_modal__label label input').click()")
      click_button 'Assign Pass Holders'
      sleep sleep_duration * 3
      page.execute_script("$('input#terms-accepted').click()")
      click_button 'Complete Reservation'
      puts "***********************************************\n"
      puts "SUCCESSFULLY RESERVED #{date}"
      puts "\n***********************************************"
      sleep sleep_duration * 6
    end
    sleep 1
  end
end

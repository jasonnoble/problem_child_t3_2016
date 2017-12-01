require 'rails_helper'

feature 'Creating robots' do
  scenario 'can create a robot' do
    make_robot
    expect(page).to have_content('Robot was successfully created.')
  end

  scenario 'index page correctly shows the newly created robot' do
    make_robot
    click_link 'Back'
    tr = find('//table/tbody/tr')
    expect(tr).to have_content('XKR-111b')
    expect(tr).to have_content('100100100')
    expect(tr).to have_content('blah blah')
    expect(tr).to have_content('true')
    expect(tr).to have_content('2016-03-17')
  end
end

feature 'Editing robots' do
  scenario 'can edit existing robot' do
    make_robot
    click_link 'Edit', match: :first
    fill_in 'Serial number', with: '9999999999z'
    click_button 'Update Robot'
    expect(page).to have_content('Robot was successfully updated.')
  end
end

feature 'Delete robots' do
  scenario 'can delete a robot' do
    make_robot
    click_link 'Back'
    click_link 'Destroy'
    expect(page).to have_content('Robot was successfully destroyed.')
  end
end

private

def make_robot
  visit '/'
  click_link 'New Robot'
  fill_in 'Model', with: 'XKR-111b'
  fill_in 'Serial number', with: '100100100'
  fill_in 'External sockets', with: 'blah blah'
  check 'Has wheels'
  select '2016', from: 'robot_date_of_manufacture_1i'
  select 'March', from: 'robot_date_of_manufacture_2i'
  select '17', from: 'robot_date_of_manufacture_3i'
  click_button 'Create Robot'
end

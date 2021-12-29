require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  let!(:owner_1) { Owner.create!(name: 'owner_1') }
  let!(:machine_1) { owner_1.machines.create!(location: 'loc_1') }
  let!(:snack_1) { machine_1.snacks.create!(name: 'snack_1', price: '1') }
  let!(:snack_2) { machine_1.snacks.create!(name: 'snack_2', price: '2') }
  let!(:snack_3) { machine_1.snacks.create!(name: 'snack_3', price: '3') }

  before(:each) do
    visit machine_path(machine_1)
  end

  describe 'view elements' do
    it 'they see the location of that machine' do 
      expect(page).to have_content(machine_1.location)
    end
  
    it 'displays list of snacks and their prices' do
      within("#snack-#{snack_1.id}") do
        expect(page).to have_content(snack_1.name)
        expect(page).to have_content(snack_1.price)
      end

      within("#snack-#{snack_2.id}") do
        expect(page).to have_content(snack_2.name)
        expect(page).to have_content(snack_2.price)
      end

      within("#snack-#{snack_3.id}") do
        expect(page).to have_content(snack_3.name)
        expect(page).to have_content(snack_3.price)
      end
    end

    it 'displays the machines average price' do
      avg_price = (snack_1.price + snack_2.price + snack_3.price).to_f / 3.0
      expect(page).to have_content("Average Price: $#{avg_price}")
    end
  end
end

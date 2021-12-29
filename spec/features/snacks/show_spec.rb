require 'rails_helper'

RSpec.describe 'snack show page', type: :feature do
  let!(:owner_1) { Owner.create!(name: 'owner_1') }
  let!(:machine_1) { owner_1.machines.create!(location: 'loc_1') }
  let!(:machine_2) { owner_1.machines.create!(location: 'loc_2') }
  let!(:machine_3) { owner_1.machines.create!(location: 'loc_3') }
  let!(:snack_1) { Snack.create!(name: 'snack_1', price: '1', machines: [machine_1, machine_2, machine_3]) }
  let!(:snack_2) { Snack.create!(name: 'snack_2', price: '2', machines: [machine_1, machine_3]) }
  let!(:snack_3) { Snack.create!(name: 'snack_3', price: '3', machines: [machine_1]) }

  before(:each) { visit snack_path(snack_1) }

  describe 'view elements' do
    it 'displays snack info' do
      expect(page).to have_content(snack_1.name)
      expect(page).to have_content('$1.00')
    end

    it 'displays snack sales locations' do
      expect(page).to have_content(machine_1.location)
      expect(page).to have_content(machine_2.location)
      expect(page).to have_content(machine_3.location)
    end

    it 'displays machine total snacks and average price' do
      within("#machine-#{machine_1.id}") do
        expect(page).to have_content(machine_1.snack_total)
        expect(page).to have_content(machine_1.avg_snack_price)
      end

      within("#machine-#{machine_2.id}") do
        expect(page).to have_content(machine_2.snack_total)
        expect(page).to have_content(machine_2.avg_snack_price)
      end

      within("#machine-#{machine_3.id}") do
        expect(page).to have_content(machine_3.snack_total)
        expect(page).to have_content(machine_3.avg_snack_price)
      end

    end
  end
end
require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
  end
  
  describe 'relationships' do
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks) }
  end

  let!(:owner_1) { Owner.create!(name: 'owner_1') }
  let!(:machine_1) { owner_1.machines.create!(location: 'loc_1') }
  let!(:snack_1) { machine_1.snacks.create!(name: 'snack_1', price: '1') }
  let!(:snack_2) { machine_1.snacks.create!(name: 'snack_2', price: '2') }
  let!(:snack_3) { machine_1.snacks.create!(name: 'snack_3', price: '3') }

  describe 'instance methods' do
    describe '#avg_snack_price' do
      it 'should return the average snack price' do
        expected = (snack_1.price + snack_2.price + snack_3.price).to_f /  3.0

        expect(machine_1.avg_snack_price).to eq(expected)
      end
    end

    describe '#snack_total' do
      it 'should return the total amount of snacks' do
        expect(machine_1.snack_total).to eq(3)
      end
    end
  end
end

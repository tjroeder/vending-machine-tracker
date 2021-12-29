class Machine < ApplicationRecord
  validates_presence_of :location
  
  belongs_to :owner
  has_many :machine_snacks
  has_many :snacks, through: :machine_snacks

  # Class Methods

  # Instance Methods
  def avg_snack_price
    snacks.average("price")
  end

  def snack_total
    snacks.count
  end
end

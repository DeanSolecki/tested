class Phone < ActiveRecord::Base
  belongs_to :contact

	validates :phone, uniqueness: {scope: :contact_id }, presence: true
end

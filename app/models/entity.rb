class Entity < ActiveRecord::Base
  has_many :tags, dependent: :destroy
  validates :entity_type, :entity_identifier, presence: true
end

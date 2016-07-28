class Tag < ActiveRecord::Base
  belongs_to :entity
  validates :entity, :name, presence: true

  scope :names, -> { uniq.pluck(:name) }
end

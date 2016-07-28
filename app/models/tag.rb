class Tag < ActiveRecord::Base
  belongs_to :entity
  validates :entity, presence: true

  scope :names, -> { uniq.pluck(:name) }
end

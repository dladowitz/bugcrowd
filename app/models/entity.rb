class Entity < ActiveRecord::Base
  has_many :tags, dependent: :destroy
  validates :entity_type, :entity_identifier, presence: true
  validates :entity_identifier, uniqueness: true

  def create_tags(tags)
    tags.each { |tag| self.tags.create(name: tag) }
  end
end

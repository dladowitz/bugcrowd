require 'rails_helper'

describe Entity do
  it { should validate_presence_of(:entity_identifier) }
  it { should validate_presence_of(:entity_type) }
  it { should validate_uniqueness_of(:entity_identifier) }
  it { should have_many :tags }

  describe "#create_tags" do
    let(:entity) { Entity.create(entity_identifier: "abc", entity_type: "article") }

    it "creates tags from an array" do
      tags = ['red', 'book', 'auto']
      entity.create_tags tags
      expect(entity.tags.count).to eq 3
    end
  end
end

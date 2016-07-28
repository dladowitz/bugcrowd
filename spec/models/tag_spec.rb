require 'rails_helper'

describe Tag do
  it { should validate_presence_of(:name) }
  it { should belong_to :entity }

  describe "#names" do
    before do
      entity = Entity.create(entity_identifier: "abc", entity_type: "article")
      entity.tags.create(name: 'book')
      entity.tags.create(name: 'auto')
      entity.tags.create(name: 'auto')
    end

    it "returns an array of unique names" do
      expect(Tag.names.length).to eq 2
    end
  end
end

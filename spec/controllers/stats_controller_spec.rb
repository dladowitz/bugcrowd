require 'rails_helper'

describe StatsController do
  before do
    entity = Entity.create(entity_identifier: "abc", entity_type: "product")
    entity.create_tags(["book", "auto"])
    entity2 = Entity.create(entity_identifier: "123", entity_type: "product")
    entity2.create_tags(["book", "hiking"])
  end

  describe "#index" do
    subject { post :index,  format: :json }
    before  do
      subject
      @json_response = JSON.parse(response.body)
    end

    it "returns all the stats for all tag names" do
      expect(@json_response.length).to eq 3
    end

    it "correctly counts up tags for each name" do
      expect(@json_response.first["count"]).to eq 2
    end
  end

  describe "#show" do
    subject { post :show, entity_identifier: "abc", format: :json }

    before  do
      subject
      @json_response = JSON.parse(response.body)
    end

    it "correctly counts up tags for the entity" do
      expect(@json_response["total_tags"]).to eq 2
    end
  end
end

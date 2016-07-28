require 'rails_helper'

describe TagsController do
  describe "#create" do
    subject { post :create, entity_identifier: "abc", entity_type: "product", tags: ["book", "auto"], format: :json }
    before  do
      subject
      @json_response = JSON.parse(response.body)
    end

    it "creates an Entity" do
      expect(@json_response["entity_identifier"]).to eq "abc"
    end

    it "creates Tags on an entity" do
      expect(Entity.last.tags.count).to eq 2
    end
  end

  context "when an entity already exists" do
    before do
      entity = Entity.create(entity_identifier: "abc", entity_type: "product")
      entity.create_tags(["book", "auto"])
    end

    describe "#show" do
      subject { get :show, entity_identifier: "abc", format: :json }
      before  do
        subject
        @json_response = JSON.parse(response.body)
      end

      it "recieves the correct entity" do
        expect(@json_response.first["entity"]["entity_identifier"]).to eq "abc"
      end

      it "recieves the correct tags" do
        expect(@json_response.first["tags"].count).to eq 2
      end
    end

    describe "#destroy" do
      subject { get :destroy, entity_identifier: "abc", format: :json }
      before  { subject }

      it "deletes the object" do
        expect(Entity.count).to eq 0
      end
    end
  end
end

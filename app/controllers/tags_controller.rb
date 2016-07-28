class TagsController < ApplicationController
  before_action :find_entity

  def create
    @entity.delete if @entity
    @entity = Entity.new(entity_identifier: params[:entity_identifier], entity_type: params[:entity_type])

    if @entity.save
      params[:tags].each do |tag|
        @entity.tags.create(name: tag)
      end

      render json: @entity, status: 201
    else
      render json: {errors: @entity.errors}, status: 422
    end
  end

  def show
    if @entity
      render json: [entity: @entity, tags: @entity.tags]
    else
      render json: {error: "No Entity Found"}, stauts: 404
    end
  end

  private

  def find_entity
    if params[:entity_identifier]
      @entity = Entity.find_by_entity_identifier(params[:entity_identifier])
    end
  end
end

class TagsController < ApplicationController
  def create
    @entity.delete if @entity

    @entity = Entity.create(entity_identifier: params[:entity_identifier], entity_type: params[:entity_type])

    params[:tags].each do |tag|
      @entity.tags.create(name: tag)
    end

    render json: @entity, status: 201
  end

  private

  def find_entity
    if params[:entity_identifier]
      @entity = Entity.find_by_entity_indentifier(params[:entity_identifier])
    end
  end
end

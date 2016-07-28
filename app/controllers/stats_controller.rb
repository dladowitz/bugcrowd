class StatsController < ApplicationController
  before_action :set_entity, only: :show
  
  def index
    stats = []
    Tag.names.each { |name| stats << {tag: name, count: Tag.where(name: name).count} }

    render json: stats
  end

  def show
    if @entity
      render json: {total_tags: @entity.tags.count}
    else
      render json: {error: "No Entity Found"}, status: 404
    end
  end

  private

  def set_entity
    @entity = Entity.find_by_entity_identifier(params[:entity_identifier])
  end
end

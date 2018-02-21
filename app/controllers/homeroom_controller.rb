class HomeroomController < ApplicationController
  def index
    @homerooms = Homeroom.all
    render json: @homerooms
  end
end

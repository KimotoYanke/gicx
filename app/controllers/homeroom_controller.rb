class HomeroomController < ApplicationController
  def index
    @homerooms = Homeroom.all
    render json: @homerooms
  end

  def show
    @homerooms = Homeroom.all
    render json: @homerooms[params[:id].to_i - 1]
  end
end

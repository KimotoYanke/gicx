class TaskController < ApplicationController
  def index
    if !params[:subject_id].nil?
      p params[:subject_id]
      @tasks = Task.where(subject_id: params[:subject_id])
    else
      @tasks = Task.all
    end
    render json: @tasks
  end
end

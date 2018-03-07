class TaskController < ApplicationController
  def index
    if !params[:subject_id].nil?
      @tasks = Task.where(subject_id: params[:subject_id])
    else
      @tasks = Task.all
    end
    @nt=[]
    @tasks.each_with_index{|t, k|
        @nt[k] = t.attributes
        @nt[k]['submissions'] = Submission.where(task_id: t.id)
    }
    render json: @nt
  end
end

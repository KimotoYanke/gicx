class SubjectController < ApplicationController
  def index
    if !params[:homeroom_id].nil?
      @subjects = Subject.where(homeroom_id: params[:homeroom_id])
    else
      @subjects = Subject.all
    end
    @ns=[]
    @subjects.each_with_index {|s, k|
      @ns[k] = s.attributes
      @ns[k]['tasks'] = s.tasks
    }
    render json: @ns
  end
end

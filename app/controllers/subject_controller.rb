class SubjectController < ApplicationController
  def index
    if !params[:homeroom_id].nil?
      @subjects = Subject.where(homeroom_id: params[:homeroom_id])
    elsif !params[:teacher].nil?
      @subjects = User.find_by(uid: params[:teacher])['subjects']
      @subjects = @subjects.map{|s|
        Subject.find(s)
      }
    else
      @subjects = Subject.all
    end
    @ns=[]
    @subjects.each_with_index {|s, k|
      @ns[k] = s.attributes
      @ns[k]['tasks'] = s.tasks
      @ns[k]['homeroom'] = s.homeroom
    }
    render json: @ns
  end
end

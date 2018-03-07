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
      @nt=[]
      s.tasks.each_with_index{|t, k2|
        @nt[k2] = t.attributes
        @nsm=[]
        Submission.where(task_id: t.id).each_with_index{|s2, k3|
            @nsm[k3] = s2.attributes

            p s2.attributes
            @nsm[k3]['user'] = s2.user
        }
        @nt[k2]['submissions'] = @nsm
      }
      @ns[k]['tasks'] = @nt
      @ns[k]['homeroom'] = s.homeroom
    }
    render json: @ns
  end
end

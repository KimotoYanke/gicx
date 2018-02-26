class SubmissionController < ApplicationController
  def index
    @submissions = Submission.all
    render json: @submissions
  end

  def create
    upload_file = content_params[:upload_file]
    content = {:is_confirming=>true, :is_passed=>false, 
               :path=>'/tmp/gicx/' + content_params[:subject] + '/' + content_params[:task] + '/' + content_params[:user]}
    if upload_file != nil
      @submission = Submission.create(content)
    end
  end
end

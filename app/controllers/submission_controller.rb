require 'fileutils' 
class SubmissionController < ApplicationController
  def index
    @submissions = Submission.all
    render json: @submissions
  end

  def create
    decoded_file = params[:decoded_file]
    path ='/tmp/gicx/' +
               params[:subject] +
               '/' +
               params[:task] +
               '/' +
               params[:user]
    filename = path + '/' + DateTime.now.to_s
    FileUtils.mkdir_p(path)

    File.open(filename, 'w+b') do |fp|
      fp.write Base64.decode64(decoded_file)
    end
    @submission = Submission.create(
      :is_confirming=>true,
      :is_passed=>false, 
      :user=>User.where(uid:params[:user]).first,
      :path=>filename,
      :task=>Task.find(params[:task]))
    render json: @submission
  end

end

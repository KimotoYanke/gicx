require 'fileutils' 
class SubmissionController < ApplicationController
  def index
    if !params[:task_id].nil?
      @submissions = Submission.where(task_id: params[:task_id])
    else
      @submissions = Submission.all
    end
    @ns=[]
    @submissions.each_with_index {|s, k|
      @ns[k] = s.attributes
      @ns[k]['user'] = s.user
    }
    render json: @ns
  end

  def create
    decoded_file = params[:decoded_file]
    path ='/tmp/gicx/' + params[:subject].to_s + '/' + params[:task].to_s + '/' + params[:user].to_s
    filename = path + '/' + DateTime.now.to_s
    FileUtils.mkdir_p(path)
    if !File.directory? path + '/.git'
      system 'cd ' + path + '; git init'
    end

    File.open(filename, 'w+b') do |fp|
      fp.write Base64.decode64(decoded_file)
    end
    system 'cd ' + path + ';git add ' + filename + '; git commit -m "' + filename + '"'
    @submission = Submission.create(
      :is_confirming=>true,
      :is_passed=>false, 
      :user=>User.where(uid:params[:user]).first,
      :uid=>params[:user],
      :path=>filename,
      :task=>Task.find(params[:task]))
    render json: @submission
  end

end

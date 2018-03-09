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
    filename = params[:filename] || DateTime.now.strftime("%Y-%m-%d_%H-%M-%S") + '.' +params[:ext]
    filepath = path + '/' + filename
    FileUtils.mkdir_p(path)
    if !File.directory? path + '/.git'
      system 'cd ' + path + '; git init'
    end

    File.open(filepath, 'w+b') do |fp|
      fp.write Base64.decode64(decoded_file)
    end
    system 'cd ' + path + ';git add ' + filepath + '; git commit -m "' + filepath + '"'
    @submission = Submission.create(
      :is_confirming=>true,
      :is_passed=>nil, 
      :user=>User.where(uid:params[:user]).first,
      :uid=>params[:user],
      :path=>filepath,
      :task=>Task.find(params[:task]))
    render json: @submission
  end

  def pass
    @sid = params[:submission_id]
    @is_passed = params[:is_passed]
    Submission.update(@sid, is_passed: @is_passed)
    render json: {}
  end

  def download
    @sid = params[:submission_id]
    @filepath=Submission.find(@sid).path
    send_file(@filepath)
  end
end

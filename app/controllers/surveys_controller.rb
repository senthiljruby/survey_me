class SurveysController < ApplicationController
  before_filter :authenticate_user!, :except => ['index']
  before_filter :admin_only, :except => ['index', 'show', 'survey_response']
  before_filter :load_survey, :only => ['show', 'destroy', 'survey_response', 'results']

  def index
    @surveys = Survey.paginate :page => params[:page], :order => 'created_at DESC'
  end

  def show
  end

  def new
    @question_type = params[:question_type]
    @survey = current_user.surveys.new
    @question = @survey.questions.new
  end

  def edit
    @survey = current_user.surveys.find(params[:id])
    @question_type = @survey.question_type
  end

  def create
    @survey = current_user.surveys.new(params[:survey])
    @question_type = params[:question_type]
    if @survey.save
      redirect_to surveys_path, notice: 'Survey was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @survey = current_user.surveys.find(params[:id])
    if @survey.update_attributes(params[:survey])
      redirect_to surveys_path, notice: 'Survey was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @survey.destroy
    redirect_to surveys_url
  end

  def survey_response
    @question = params[:question_ids]
    @user_answer = params[:user_answers]
    responses = []
    @question.each_with_index do |question, key|
      @response = current_user.responses.create(:survey_id => @survey.id, :question_id => question, :user_answer => @user_answer[key])
      responses << @response.errors.full_messages
    end
    if responses.flatten.empty?
      redirect_to root_path, notice: 'Survey was successfully completed.'
    else
      redirect_to survey_path(@survey), notice: "#{responses.uniq.flatten.join('<br />')}".html_safe
    end
  end

  def results
    @responses = @survey.responses.paginate :page => params[:page], :order => 'created_at DESC'
  end

  private
  def load_survey
    @survey = Survey.find(params[:id])    
  end
end

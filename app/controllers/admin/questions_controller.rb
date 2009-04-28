class Admin::QuestionsController < ApplicationController

  before_filter :require_admin
  
  def index
    @flags = Flag.questions.paginate(:page => params[:page] || 1 , :per_page => 20)
  end
  
  def show
    @question = Question.find(params[:id])
    render "/questions/show"
  end
  
  
  def ban
    @flag = Flag.find(params[:id])
    @question = @flag.flaggeable
    @question.toggle!(:banned)
    if @question.banned
      flash[:notice] = "La pregunta a sido restringida"
    else
      flash[:notice] = "La pregunta a sido reaceptada"
    end
    respond_to do |format|
      format.js {}
    end
  end
  
  def destroy
    @flag = Flag.questions.find(params[:id])
    @flag.destroy
    flash[:notice] = "La reportacion ha sido borrada"
    redirect_to admin_questions_path()
  end
end

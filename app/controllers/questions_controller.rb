class QuestionsController < ApplicationController
  before_filter :find_question, only: [:show, :edit, :update, :answer]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      redirect_to root_path, notice: 'Question created successfully.'
    else
      render :new
    end
  end

  def update
    if @question.update_attributes question_params
      redirect_to root_path, notice: 'Question saved successfully.'
    else
      render :edit
    end
  end

  def answer
    # TODO
    hash = params[:answer]
    @answer = hash[:answer.to_s]
    
    @result = @question.is_correct?(@answer) 
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question, :answer)
  end
end

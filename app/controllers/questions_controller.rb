class QuestionsController < ApplicationController
  def new
    user = User.find(session[:user_id])
    if user.credits > 0
      QuestionsFacade.new.get_response(question_params, user)
    else
      flash[:error] = "You've asked The Crawfather too many questions, capisce?"
      redirect_to "/home"
    end
    redirect_to "/home"
  end

  private
  def question_params
    params.permit(:question)
  end
end
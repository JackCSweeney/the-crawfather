class QuestionsFacade
  def get_response(question_params, user)
    response = QuestionsService.new.post_question(question_params[:question])
    question = user.questions.create!({question: question_params[:question], response: response})
  end
end
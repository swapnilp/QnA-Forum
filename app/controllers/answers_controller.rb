class AnswersController < ApplicationController

  def new
    @answer = Answer.new
  end

  def create
    if user_signed_in?
      @question = Question.find(params[:question_id])
      @answer = Answer.new(params[:answer])
      respond_to do |format|
        @answer[:user_id] = current_user.id
        @answer[:question_id] = params[:question_id]
        @user = User.find(@question.user_id)
        @rss = Rss.new(:user_id => current_user.id, :comment => "has answered the question", :location => "questions/#{@answer.question_id.to_s}")
        if @answer.save
          @rss.save
          UserMailer.email_to_owner(@user, @answer).deliver
          format.html { redirect_to question_path(@answer.question_id), notice: 'Answer was successfully created.' }
          format.json { render json: @answer, status: :created, location: @answer }          
        else
          format.html { render action: "new" }
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    answer_user_id = Answer.find(params[:id]).user_id
    puts Rss.new(:user_id => current_user.id, :comment => " has give rating to answer", :location => "questions/#{Answer.find(params[:id]).question_id}").save
    User.find(answer_user_id).update_attribute(:karma, User.find(answer_user_id).karma + 1) if (params[:answer][:rating]).to_i > 2
    Answerrating.new(:user_id => current_user.id, :answer_id=> params[:id], :rating => params[:answer][:rating].to_i ).save
    total_rating = (Answer.find(params[:id]).rating + (params[:answer][:rating].to_f)) / 2
    Answer.find(params[:id]).update_attribute(:rating, total_rating)
    redirect_to questions_path
  end

end

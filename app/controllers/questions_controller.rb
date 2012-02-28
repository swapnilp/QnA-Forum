class QuestionsController < ApplicationController
  def index
    # @question = Question.all
    @questions = Question.paginate(:page => params[:page], :per_page => 10)
    @question = Question.new
    @rss = Rss.limit(10).order('created_at desc')
    respond_to do |format|
      format.html # index.html.haml
      format.js# { render json: @question }
    end
  end  
  
  def show
    @rating_arr = [1, 2, 3, 4, 5]
    @question = Question.find(params[:id])
    @answers = Answer.find(:all, :conditions => {:question_id => @question.id})
    @answer = Answer.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end
  
  def new
    @question = Question.new
    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.json { render json: @question }
    #end
  end
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def create
    if user_signed_in?
      @question = Question.new(params[:question])
      respond_to do |format|
        @question[:user_id] = current_user.id
        puts @question[:user_id]
        if @question.save
          Rss.new(:user_id => current_user.id, :comment => "created new question", :location => "questions/#{@question.id}").save
          @questions = Question.paginate(:page => params[:page], :per_page => 10)
          @rss = Rss.find(:all, :order => "created_at DESC")
          #render :action => "index"
          format.html { render :action => "index", notice: 'Question was successfully created.' }
          format.js #{ render json: @questions, status: :created, location: @questions }
        else
          format.html { render action: "new" }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def update
    @question = Question.find(params[:id])
    Rss.new(:user_id => current_user.id, :comment => "created new question", :location => "questions/#{@question.id}").save
    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    
    respond_to do |format|
      format.html { redirect_to question_url }
      format.json { head :no_content }
    end
  end

end

class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :accept]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  def accept
    # barter = Barter.find(params[:id])
    # barter.update_attribute(:comment, :accept => true)
    # comment = Comment.find(params[:comment_id)
    # comment = Comment.find(id)
    # comment.update_attribute(:accept => true)
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @comment.barter = Barter.find(params[:barter_id])
    @comment.user = current_user
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.barter = Barter.find(params[:barter_id])
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.barter, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # The view will talk to this controller, and run this method. This method will talk to the model and change a value in the database, by running the 'set_accepted' method.
  def accept
    @comment.set_accepted
    barter = @comment.barter_id
    # on barter table pull barter id and update value to true
    Barter.find(barter).update(accept: true)
    redirect_to barter_path(barter)
  end

  def decline
    @comment = Comment.find(params[:id])
    @comment.accept = false
    @comment.save
    barter = @comment.barter_id
    redirect_to barter_path(barter)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :barter_id)
    end
end

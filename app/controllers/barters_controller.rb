class BartersController < ApplicationController
  before_action :set_barter, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:landing, :index, :goods, :services]

  # GET /barters
  # GET /barters.json

  def landing
  end

  def index
    target_expiration = Date.today
    @barters = Barter.where("expiration >= ?", target_expiration)
  end

  def goods
    target_category = 'Goods'
    target_expiration = Date.today
    @barters = Barter.where("expiration >= ? AND category = ?", target_expiration, target_category)
  end

  def services
    target_category = 'Services'
    target_expiration = Date.today
    @barters = Barter.where("expiration >= ? AND category = ?", target_expiration, target_category)
  end

  def hillcrest
    target_neighborhood = 'hillcrest'
    target_expiration = Date.today
    @barters = Barter.where("expiration >= ? AND neighborhood = ?", target_expiration, target_neighborhood)
  end

  def north_park
    target_neighborhood = 'north park'
    target_expiration = Date.today
    @barters = Barter.where("expiration >= ? AND neighborhood = ?", target_expiration, target_neighborhood)
  end

  def kensington
    target_neighborhood = 'kensington'
    target_expiration = Date.today
    @barters = Barter.where("expiration >= ? AND neighborhood = ?", target_expiration, target_neighborhood)
  end

  def university_heights
    target_neighborhood = 'university heights'
    target_expiration = Date.today
    @barters = Barter.where("expiration >= ? AND neighborhood = ?", target_expiration, target_neighborhood)
  end

  def little_italy
    target_neighborhood = 'little italy'
    target_expiration = Date.today
    @barters = Barter.where("expiration >= ? AND neighborhood = ?", target_expiration, target_neighborhood)
  end


  def select
      @barter = Barter.find(params[:id])
  end

  # GET /barters/1
  # GET /barters/1.json
  def show
      @barter = Barter.find(params[:id])
      @barters = @barter.comments
      @user = User.find(@barter.user_id)
      if @barters && @barters.length > 0
          @comment_id = @barters.last.id
      else
          @comment_id = 0
      end
  end

  def accept
    comment = Comment.find(id)
    comment.accept = true
    comment.save
  end

  def decline
  end


  # GET /barters/new
  def new
    @barter = current_user.barters.build
  end

  # GET /barters/1/edit
  def edit
      @barter = Barter.find(params[:id])
  end

  # POST /barters
  # POST /barters.json
  def create
      if barter_params[:expiration] >= Date.today.to_s
          @barter = current_user.barters.build(barter_params)

          respond_to do |format|
              if @barter.save
                  format.html { redirect_to @barter, notice: 'Barter was successfully created.' }
                  format.json { render :show, status: :created, location: @barter }
              else
                  format.html { render :new }
                  format.json { render json: @barter.errors, status: :unprocessable_entity }
              end
          end
      else
        redirect_to new_barter_path, {alert: 'Barter must be created with an expiration date equal to today or later'}
      end
  end

  # PATCH/PUT /barters/1
  # PATCH/PUT /barters/1.json
  def update
    respond_to do |format|
      if @barter.update(barter_params)
        format.html { redirect_to @barter, notice: 'Barter was successfully updated.' }
        format.json { render :show, status: :ok, location: @barter }
      else
        format.html { render :edit }
        format.json { render json: @barter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /barters/1
  # DELETE /barters/1.json
  def destroy
    @barter.destroy
    respond_to do |format|
      format.html { redirect_to barters_url, notice: 'Barter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_barter
    @barter = Barter.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def barter_params
    params.require(:barter).permit(:product, :description, :category, :neighborhood, :interested_in, :expiration, :image)
  end
end

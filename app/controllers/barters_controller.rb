class BartersController < ApplicationController
  before_action :set_barter, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:landing, :index, :goods, :services]

  # GET /barters
  # GET /barters.json

  def landing
  end

  def index
    @barters = Barter.all
    # @user = current_user
  end

  def goods
    @barters = Barter.where(category: 'Goods')
  end

  def services
    @barters = Barter.where(category: 'Services')
  end

  def hillcrest
    filter_neighborhood('hillcrest')
  end

  def north_park
    filter_neighborhood('north park')
  end

  def kensington
    filter_neighborhood('kensington')
  end

  def university_heights
    filter_neighborhood('university heights')
  end

  def little_italy
    filter_neighborhood('little italy')
  end


  def filter_neighborhood(neighborhood)
    barters = Barter.all
    if barters.empty?
      @barters = Barter.all
    else
      @barters = Barter.where(neighborhood: neighborhood)
    end
  end

  def filter_category(category)

  end

  # GET /barters/1
  # GET /barters/1.json
  def show
    @barter = Barter.find(params[:id])
  end

  # GET /barters/new
  def new
    @barter = Barter.new
  end

  # GET /barters/1/edit
  def edit
  end

  # POST /barters
  # POST /barters.json
  def create
    @barter = Barter.new(barter_params)

    respond_to do |format|
      if @barter.save
        format.html { redirect_to @barter, notice: 'Barter was successfully created.' }
        format.json { render :show, status: :created, location: @barter }
      else
        format.html { render :new }
        format.json { render json: @barter.errors, status: :unprocessable_entity }
      end
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
    params.require(:barter).permit(:product, :description, :category, :neighborhood, :expiration)
  end
end

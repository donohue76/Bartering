class BartersController < ApplicationController
  before_action :set_barter, only: [:show, :edit, :update, :destroy]

  # GET /barters
  # GET /barters.json

  # homepage
  def landing
  end

  # accesses db & finds barters table & stores all items inside
  # the @barters instance variable
  def index
    @barters = Barter.all
  end

  # accesses db & finds barters table & stores all goods inside
  # the @ barters instance variable
  def goods
    @barters = Barter.where(:category => 'goods')
  end

  # accesses db & finds barters table & stores all services inside
  # the @ barters instance variable
  def services
    @barters = Barter.where(:category => 'services')
  end

  # accesses db & finds barters table & stores all hillcrest items inside
  # the @barters instance variable
  def hillcrest
    filter_neighborhood('hillcrest')
  end

  # accesses db & finds barters table & stores all north park items inside
  # the @barters instance variable
  def north_park
    filter_neighborhood('north park')
  end

  # accesses db & finds barters table & stores all kensington items inside
  # the @barters instance variable
  def kensington
    filter_neighborhood('kensington')
  end

  # accesses db & finds barters table & stores all university heights items inside
  # the @barters instance variable
  def university_heights
    filter_neighborhood('university heights')
  end

  # accesses db & finds barters table & stores all little italy items inside
  # the @barters instance variable
  def little_italy
    filter_neighborhood('little italy')
  end

  # finters all listings by neighborhood
  def filter_neighborhood(neighborhood)
    barters = Barter.all
    if barters.empty?
      @barters = Barter.all
    else
      @barters = Barter.where(neighborhood: neighborhood)
    end
  end

  # def filter_category(category)
  # end

  # GET /barters/1
  # GET /barters/1.json
  def show
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
      params.require(:barter).permit(:product, :description, :category, :neighborhood, :city, :state, :zip, :expiration)
    end
end

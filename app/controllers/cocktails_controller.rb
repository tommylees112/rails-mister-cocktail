class CocktailsController < ApplicationController
  before_action :find_cocktail, only: [:show, :destroy]

  def home
  end

  def index #GET "cocktails"
    @cocktails = Cocktail.all
  end

  def show # GET "cocktails/42"
    @dose = Dose.new
  end

  def new #GET "cocktails/new"
    @cocktail = Cocktail.new
    @cocktail.doses.build #WTF
  end

  def create
    @cocktail = Cocktail.create(cocktail_params)
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    @dose.save

    if @cocktail && @dose
      redirect_to cocktails_path
    else
      render :new
    end
  end

  def destroy
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo) #, :photo_cache --> for CarrierWave
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def dose_params
    params.require(:cocktail).require(:doses).permit(:ingredient_id, :description)
  end


end

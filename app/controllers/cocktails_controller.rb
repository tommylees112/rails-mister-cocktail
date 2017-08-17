class CocktailsController < ApplicationController
  before_action :find_cocktail, only: [:show]

  def index #GET "cocktails"
    @cocktails = Cocktail.all
  end

  def show # GET "cocktails/42"
    @dose = Dose.new
  end

  def new #GET "cocktails/new"
    @cocktail = Cocktail.new
  end

  def create #POST "cocktails"
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end

class DosesController < ApplicationController
  before_action :find_dose, only: [:destroy]
  before_action :find_cocktail, only: [:new, :create]

  def new # GET "cocktails/42/doses/new" POST "cocktails/42/doses"
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy #DELETE "doses/25"
    @dose.destroy
    redirect_to root_path
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :cocktail_id, :ingredient_id)
  end

  def find_dose
    @dose = Dose.find(params[:id])
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
end

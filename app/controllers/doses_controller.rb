class DosesController < ApplicationController
  before_action :find_cocktail, only: [:destroy]

  def new # GET "cocktails/42/doses/new" POST "cocktails/42/doses"
    @dose = Dose.new()
  end

  def create
    dose = Dose.new(dose_params)
    cocktail = Cocktail.find(params[:cocktail_id])
    dose.cocktail = cocktail
    if dose.save
      redirect_to cocktail_path(params[:cocktail_id])
    else
      render :new
    end
  end

  def destroy
    @dose.destroy
    redirect_to
  end

  private

  def dose_params
    params.require(:dose).permit(:name)
  end

  def find_doses
    @dose = Dose.find(params[:dose_id])
  end
end

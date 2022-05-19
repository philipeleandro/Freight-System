class PricesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @price = Price.new
  end

  def create
    @price = Price.new(price_params)

    if @price.save
      redirect_to root_path, notice: 'Intervalo de preço cadastrado'
    else
      flash.now[:notice] = 'Preço não cadastrado'
      render 'new'
    end
  end

  private
  def price_params
    params.require(:price).permit(:min_volume, :max_volume, :min_weight, :max_weight, :value, :company_id)
  end
end
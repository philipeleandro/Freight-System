class CarsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to root_path, notice: 'Cadastrado com Sucesso'
    else
      flash.now[:notice] = 'Carro não cadastrado'
      render 'new'
    end
  end

  private
  def car_params
    params.require(:car).permit(:model, :brand, :year, :max_load, :company_id, :plate)
  end
end
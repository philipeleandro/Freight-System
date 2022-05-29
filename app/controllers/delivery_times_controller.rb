# DeliveryTimes Actions

class DeliveryTimesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    if current_user.kind == 'Regular'
      @delivery_times = DeliveryTime.all
    else
      redirect_to companies_path, notice: 'Erro ao carregar a página'
    end
  end

  def new
    if current_user.kind == 'Regular'
      @delivery_time = DeliveryTime.new
    else
      redirect_to companies_path, notice: 'Erro ao carregar a página'
    end
  end

  def create
    @delivery_time = DeliveryTime.new(delivery_time_params)

    if @delivery_time.save
      redirect_to root_path, notice: 'Intervalo de prazo cadastrado'
    else
      flash.now[:notice] = 'Prazo não cadastrado'
      render 'new'
    end
  end

  private

  def delivery_time_params
    params.require(:delivery_time).permit(:min_distance, :max_distance, :days, :company_id)
  end
end

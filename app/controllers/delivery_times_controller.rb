class DeliveryTimesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @delivery_times = DeliveryTime.all
  end
  
  def new
    @delivery_time = DeliveryTime.new
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

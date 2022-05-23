class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @orders = Order.all
  end

  def new
    @product = Product.new
    @order = Order.new
  end

  def create
    @product = Product.create(product_params)

    @order = Order.new(order_params)
    @order.product_id = @product.id

    if @order.save
      redirect_to root_path, notice: 'Ordem de serviço cadastrada'
    else
      flash.now[:notice] = 'Ordem de serviço não cadastrado'
      render 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to orders_path, notice: 'Ordem de serviço atualizada'
    else
      flash.now[:notice] = 'Não foi possível finalizar'
      render 'edit'
    end
  end

  private
  def product_params
    params.require(:order)["product"].permit(:width, :depth, :height, :weight, :sku, :address)
  end

  def order_params
    params.require(:order).permit(:receiver_name, :delivery_address, :company_id, :car_id, :code, :status, :product_id) 
  end
end
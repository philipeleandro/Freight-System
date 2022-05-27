class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]

  def index
    @orders = Order.all
  end

  def new
    if user_signed_in?
      if current_user.kind == 'Admin'
        @product = Product.new
        @order = Order.new
      else
        redirect_to root_path, notice: 'Página não pode ser carregada'
      end
    end
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
    end
  end

  def search
    @code = params["query"]
    @order = Order.find_by(code: @code)
    @product = Product.find_by(id: @order.product_id)
  end

  private
  def product_params
    params.require(:order)["product"].permit(:width, :depth, :height, :weight, :sku, :address)
  end

  def order_params
    params.require(:order).permit(:receiver_name, :delivery_address, :company_id, :car_id, :code, :status, :product_id, :date, :position, :time) 
  end
end
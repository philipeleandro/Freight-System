class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  def index
    if current_user.kind == "Admin"
      @companies = Company.all
    else
      redirect_to root_path, notice: 'Página não pode ser carregada'
    end
  end

  def new
    if current_user.kind == 'Admin'
      @company = Company.new
    else
      redirect_to root_path, notice: 'Erro ao carregar a página'
    end
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
      redirect_to companies_path, notice: 'Cadastrado com sucesso'
    else
      flash.now[:notice] = 'Empresa não cadastrado'
      render 'new'
    end
  end

  private
  def company_params
    params.require(:company).permit(:corporate_name, :brand_name, :cnpj, :address, :freight, :threshold, :domain, :user_id)
  end
end
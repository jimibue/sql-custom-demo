class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    # @customers = current_user.customers
    @customers = Customer.all_customers(current_user.id)
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    # current_user.customers.create(customer_params)
    Customer.create_customer(customer_params, current_user.id)
    redirect_to customers_path
  end

  def edit
  end

  def update
    @customer.update(customer_params)
    redirect_to customers_path
  end

  def destroy
    # @customer.destroy
    Customer.destroy_customer(@customer.id)
    redirect_to customers_path
  end

  private

  def set_customer
    # @customer = current_user.customers.find(params[:id])
    @customer = Customer.single_customer(current_user.id, params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone)
  end
end

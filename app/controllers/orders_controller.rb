class OrdersController < ApplicationController

  before_action :require_login

  def index
    @orders = Order.where(user_id:current_user.id).limit(100)
  end

  def create
    product_id = params[:product_id]
    product_sku = params[:product_sku]
    amount = 1
    begin
      @response = RestClient.patch "http://localhost:4000/products/place_order/#{product_id}.json",
                                   amount: amount,
                                   token: '4d7cc42e0fcfe5'
      Order.create user_id:current_user.id, product_id: product_id, product_sku: product_sku, amount: 1
      redirect_to orders_path, notice: "Successfully create Order!"
    rescue => e
      redirect_to products_path, notice: "Code: #{e.response.code} Message:#{e.response}"
    end
  end

end

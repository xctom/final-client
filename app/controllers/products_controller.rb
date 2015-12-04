class ProductsController < ApplicationController

  def index
    begin
      # No need for token, user can check products without login
      @response = RestClient.get 'http://localhost:4000/products.json?token=4d7cc42e0fcfe5'
      @products = JSON.parse(@response.to_str)
    rescue => e
      e.response
    end
  end

end

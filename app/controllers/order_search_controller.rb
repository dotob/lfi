class OrderSearchController < ApplicationController
  respond_to :json

  def search
    respond_with Order.where("login LIKE \"%#{params[:searchterm]}%\"").limit(100)

  end
end

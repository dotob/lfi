class OrderSearchController < ApplicationController
  respond_to :json

  def search
    respond_with Order.where("name LIKE \"%#{params[:searchterm]}%\"").limit(100)

  end
end

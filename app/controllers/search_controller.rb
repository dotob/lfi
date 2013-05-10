class SearchController < ApplicationController
  respond_to :json

  def order_search
    result = Result.new
    query = "login LIKE \"%#{params[:searchterm]}%\" OR name LIKE \"%#{params[:searchterm]}%\" OR key LIKE \"%#{params[:searchterm]}%\""
    if params[:limit].to_i > 0
      items = Order.where(query).limit(params[:limit])
    else
      items = Order.where(query)
    end
    result.items = items
    result.copy_targets = CopyTarget.all
    respond_with result
  end
  
  def image_search
    result = Result.new
    query = "path LIKE \"%#{params[:searchterm]}%\""
    if params[:limit].to_i > 0
      items = Image.where(query).limit(params[:limit])
    else
      items = Image.where(query)
    end
    result.items = items
    respond_with result
  end
end

class Result
  attr_accessor :items
  attr_accessor :copy_targets
end


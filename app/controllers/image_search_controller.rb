class ImageSearchController < ApplicationController
  respond_to :json

  def search
    respond_with Image.where("path LIKE \"%#{params[:searchterm]}%\"").limit(100)

  end
end

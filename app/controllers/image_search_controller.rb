class ImageSearchController < ApplicationController
  respond_to :json

  def search
    @images = Image.where("path LIKE ?", params[:searchterm])
  end
end

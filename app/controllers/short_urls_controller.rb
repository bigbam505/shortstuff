class ShortUrlsController < ApplicationController
  def new
  end

  def create
    short_url = ShortUrl.new(url: params[:url], name: params[:name])
    if short_url.save
      flash[:notice] = "Your url: #{short_url.full_url}"
      redirect_to new_short_url_path
    else
      @errors = short_url.errors
      render :new
    end

  end

  def show
    short_url = ShortUrl.find_by_name(params[:name])
    if short_url
      redirect_to short_url.url
    else
      flash[:notice] = "This link does not exist."
      redirect_to root_path
    end
  end
end

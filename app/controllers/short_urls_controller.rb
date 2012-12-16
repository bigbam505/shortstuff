class ShortUrlsController < ApplicationController
  def new
  end

  def create
    short_url = ShortUrl.new(url: params[:url], name: params[:name])
    if short_url.save
      flash[:notice] = "Your url: #{short_url.full_url}"
    else
      flash[:error] = "#{short_url.name} is already taken"
    end

    redirect_to new_short_url_path
  end

  def show
    short_url = ShortUrl.find_by_name(params[:name])
    redirect_to short_url.url
  end
end

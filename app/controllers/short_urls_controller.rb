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
end

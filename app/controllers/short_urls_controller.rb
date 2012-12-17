class ShortUrlsController < ApplicationController
  respond_to :json, :html

  def new
  end

  def create
    short_url = ShortUrl.new(url: params[:url], name: params[:name])
    if short_url.save
      flash[:notice] = "Your url: #{short_url.full_url}"
      respond_to do |format|
        format.html { redirect_to new_short_url_path }
        format.json { render json: short_url.to_json }
      end
    else
      @errors = short_url.errors
      respond_to do |format|
        format.html { render :new }
        format.json { render json: {errors: @errors }, status: :error }
      end
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

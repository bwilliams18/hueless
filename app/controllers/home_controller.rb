class HomeController < ApplicationController

  before_filter :fetch_bulb, except: :index

  def index
  end

  def off
    @bulb.update(on: false)
    render json: { state: "off" }
  end

  def on
    @bulb.update(on: true)
    render json: { state: "on" }
  end

  def color
    @bulb.update(rgb: params[:color])
    render json: { color: params[:color] }
  end

  def xy
    xy = [params[:x].to_f.round(2), params[:y].to_f.round(2)]
    puts xy
    @bulb.update(xy: xy, bri: 255, transitiontime: 10)
    render json: { xy: xy }
  end

  def brightness
    @bulb.update(bri: params[:bri].to_i)
    render json: { bri: params[:bri] }
  end

  def alert
    @bulb.alert!
    render json: { alert: true }
  end

  def fetch_bulb
    if params[:id] == "all"
      @bulb = Huey::Bulb.all
    else
      @bulb = Huey::Bulb.find(params[:id].to_i)
    end
  end
end

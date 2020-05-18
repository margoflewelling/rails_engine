class Api::V1::Merchants::StatsController < ApplicationController

  def most_revenue
    require "pry"; binding.pry
    limit = params[:quantity]
    
    render json: MerchantSerializer.new(merchants).serialized_json
  end

end

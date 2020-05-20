class Api::V1::RevenueController < ApplicationController

  def dates
    start_date = params["start"] + " 00:00:01 UTC"
    end_date = params["end"] + " 23:59:59 UTC"
    revenue = Invoice.revenue_between(start_date, end_date)
    render json: "{\"data\":{\"id\":\"null\",\"type\":\"revenue\",\"attributes\":{\"revenue\":#{revenue}}}}"
  end

end

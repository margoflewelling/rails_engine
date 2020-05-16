require 'rails_helper'

describe "Merchants API" do
  it "sends a list of all merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
    expect(merchants.has_key?("data")).to eq(true)
    expect(merchants.is_a? Hash).to eq(true)
  end
end

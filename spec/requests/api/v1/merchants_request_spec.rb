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

  it "can show a specific merchant" do
    id = create(:merchant).id
    get "/api/v1/merchants/#{id}"
    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can create a new merchant" do
    merchant_params = {name: "Billy Bob"}
    post "/api/v1/merchants", params: {merchant: merchant_params}
    merchant = Merchant.last
    expect(response).to be_successful
    expect(merchant.name). to eq(merchant_params[:name])
  end

  it "can destroy a merchant" do
    merchant = create(:merchant)
    expect(Merchant.count).to eq(1)
    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)
    expect(response).to be_successful
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

end

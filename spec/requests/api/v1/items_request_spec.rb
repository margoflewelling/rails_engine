require 'rails_helper'

describe "Items API" do
  it "sends a list of all items" do
    create_list(:item, 5)
    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(5)
    expect(items.has_key?("data")).to eq(true)
    expect(items.is_a? Hash).to eq(true)
  end

  xit "can show a specific merchant" do
    id = create(:merchant).id
    get "/api/v1/merchants/#{id}"
    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  xit "can create a new merchant" do
    merchant_params = {name: "Billy Bob"}
    post "/api/v1/merchants", params: {merchant: merchant_params}
    merchant = Merchant.last
    expect(response).to be_successful
    expect(merchant.name). to eq(merchant_params[:name])
  end

  xit "can destroy a merchant" do
    merchant = create(:merchant)
    expect(Merchant.count).to eq(1)
    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)
    expect(response).to be_successful
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  xit "can update a merchant" do
    merchant = create(:merchant)
    original_name = merchant.name
    merchant_params = {name: "Izzy's IceCream"}
    put "/api/v1/merchants/#{merchant.id}", params: {merchant: merchant_params}
    updated = Merchant.find_by(id: merchant.id)
    expect(response).to be_successful
    expect(updated.name).to_not eq(original_name)
    expect(updated.name).to eq("Izzy's IceCream")
  end
end

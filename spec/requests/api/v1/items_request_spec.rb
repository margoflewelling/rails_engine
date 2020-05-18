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

  it "can show a specific item" do
    id = create(:item).id
    get "/api/v1/items/#{id}"
    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(id.to_s)
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = {name: "Paddleboard",
                   description: "Enjoy your summer on the water",
                   unit_price: 110.99,
                   merchant_id: merchant.id}
    post "/api/v1/items", params: item_params
    item = Item.last
    expect(response).to be_successful
    expect(item.name). to eq(item_params[:name])
  end

  it "can destroy an item" do
    item = create(:item)
    expect(Item.count).to eq(1)
    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)
    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can update an item" do
    item = create(:item)
    original_name = item.name
    item_params = {name: "Izzy's IceCream"}
    put "/api/v1/items/#{item.id}", params: item_params
    updated = Item.find_by(id: item.id)
    expect(response).to be_successful
    expect(updated.name).to_not eq(original_name)
    expect(updated.name).to eq("Izzy's IceCream")
  end

  it "can get the merchant associated with the item" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item = create(:item, merchant_id: merchant1.id)
    get "/api/v1/items/#{item.id}/merchant"
    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(merchant1.id.to_s)
  end

  xit "can find an item by a search parameter" do
    item1 = create(:item, name: "Denim Overalls", merchant_id: 8)
    item2 = create(:item, name: "Paddleboard", merchant_id: 2)
    item3 = create(:item, name: "Cutting board", merchant_id: 3)
    get "/api/v1/items/find?name=board&merchant_id=3"
    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"].first["id"]).to eq(item3.id.to_s)
  end

end

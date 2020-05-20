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
    post "/api/v1/merchants", params: merchant_params
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

  it "can update a merchant" do
    merchant = create(:merchant)
    original_name = merchant.name
    merchant_params = {name: "Izzy's IceCream"}
    put "/api/v1/merchants/#{merchant.id}", params: merchant_params
    updated = Merchant.find_by(id: merchant.id)
    expect(response).to be_successful
    expect(updated.name).to_not eq(original_name)
    expect(updated.name).to eq("Izzy's IceCream")
  end

  it "can return all items associated with a merchant" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant1.id)
    item4 = create(:item, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"
    expect(response).to be_successful
    merchant_items = JSON.parse(response.body)
    expect(merchant_items["data"].count).to eq(3)
    expect(merchant_items.has_key?("data")).to eq(true)
    expect(merchant_items.is_a? Hash).to eq(true)
  end

  it "can find a merchant by a search parameter" do
    merchant1 = create(:merchant, name: "Izzy's Ice Cream")
    merchant2 = create(:merchant, name: "Creamsicle Shop")
    merchant3 = create(:merchant, name: "Al's Burgers")

    get "/api/v1/merchants/find?name=cream&updated_at=#{merchant1.updated_at}"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["id"]).to eq(merchant1.id.to_s)
  end

  it "can search with a date parameter to find merchants" do
    merchant1 = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")
    merchant2 = create(:merchant, updated_at: "2012-03-25 14:53:59 UTC")
    merchant3 = create(:merchant, updated_at: "2011-03-27 14:53:59 UTC")
    get "/api/v1/merchants/find?updated_at=2012-03-27"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["id"]).to eq(merchant1.id)
  end


  it "can find all merchants matching params" do
    merchant1 = create(:merchant, name: "Izzy's Ice Cream")
    merchant2 = create(:merchant, name: "Creamsicle Shop")
    merchant3 = create(:merchant, name: "Al's Burgers")

    get "/api/v1/merchants/find_all?name=cream"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(2)
    names = merchants["data"].map do |merchant|
      merchant["attributes"]["name"].downcase
    end
    names.each do |name|
      expect(name).to include('cream')
    end
  end

  it "can get merchants with most revenue" do
    customer = create(:customer)
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    invoice3 = create(:invoice, merchant_id: merchant3.id, customer_id: customer.id)

    item = create(:item, merchant_id: merchant1.id, id: 1)

    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 4, unit_price: 10, item_id: 1)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 3, unit_price: 20, item_id: 1)
    invoice_item3 = create(:invoice_item, invoice_id: invoice3.id, quantity: 1, unit_price: 30, item_id: 1)
    invoice_item4 = create(:invoice_item, invoice_id: invoice3.id, quantity: 1, unit_price: 100, item_id: 1)

    transaction1 = create(:transaction, invoice_id: invoice1.id )
    transaction2 = create(:transaction, invoice_id: invoice2.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id, result: "failed")
    transaction4 = create(:transaction, invoice_id: invoice3.id, result: "failed")
    get '/api/v1/merchants/most_revenue?quantity=2'
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"].first["id"]).to eq(merchant2.id.to_s)
    expect(merchants["data"].last["id"]).to eq(merchant1.id.to_s)
  end

  it "can get merchants with most items sold" do
    customer = create(:customer)
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    invoice3 = create(:invoice, merchant_id: merchant3.id, customer_id: customer.id)

    item = create(:item, merchant_id: merchant1.id, id: 1)

    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 4, unit_price: 10, item_id: 1)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 3, unit_price: 20, item_id: 1)
    invoice_item3 = create(:invoice_item, invoice_id: invoice3.id, quantity: 1, unit_price: 30, item_id: 1)
    invoice_item4 = create(:invoice_item, invoice_id: invoice3.id, quantity: 5, unit_price: 100, item_id: 1)

    transaction1 = create(:transaction, invoice_id: invoice1.id )
    transaction2 = create(:transaction, invoice_id: invoice2.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id)
    transaction4 = create(:transaction, invoice_id: invoice3.id, result: "failed")
    get '/api/v1/merchants/most_items?quantity=1'
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].first["attributes"]["id"]).to eq(merchant3.id)
  end

  it "can get revenue for a merchant" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    customer = create(:customer)
    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice2 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice3 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant1.id, id: 1)
    item2 = create(:item, merchant_id: merchant2.id, id: 2)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 3 , unit_price: 10, item_id: 1)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 3 , unit_price: 20, item_id: 1)
    invoice_item3 = create(:invoice_item, invoice_id: invoice3.id, quantity: 1 , unit_price: 30, item_id: 2)
    transaction1 = create(:transaction, invoice_id: invoice1.id )
    transaction2 = create(:transaction, invoice_id: invoice2.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id)
    get "/api/v1/merchants/#{merchant1.id}/revenue"
    expect(response).to be_successful
    revenue = JSON.parse(response.body)
    expect(revenue["data"]["id"]).to eq(merchant1.id.to_s)
    expect(revenue["data"]["attributes"]["revenue"]).to eq(90)
  end

  xit "can get all revenue for all merchants across date range" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    customer = create(:customer)
    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice2 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice3 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant1.id, id: 1)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 3 , unit_price: 10, item_id: 1)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 4 , unit_price: 20, item_id: 1)
    invoice_item3 = create(:invoice_item, invoice_id: invoice3.id, quantity: 1 , unit_price: 30, item_id: 1)
    transaction1 = create(:transaction, invoice_id: invoice1.id, created_at: "2012-03-10 14:53:59 UTC")
    transaction2 = create(:transaction, invoice_id: invoice2.id, created_at: "2012-04-08 14:53:59 UTC")
    transaction3 = create(:transaction, invoice_id: invoice3.id, created_at: "2012-03-20 14:53:59 UTC")
    get "/api/v1/revenue?start=2012-03-09&end=2012-03-24"
    expect(response).to be_successful
    revenue = JSON.parse(response.body)
    expect(revenue["data"]["id"]).to eq(merchant1.id)
    expect(revenue["data"]["attributes"]["revenue"]).to eq(60)
  end






end

require 'csv'

# Dir.glob("#{Rails.root}/app/models/*.rb").each { |file| require file }

# Customer.delete_all
# InvoiceItem.delete_all
namespace :import do

desc "All"
   task all: [:customers, :invoice_items, :invoices, :items, :merchants, :transactions]


desc "Import customers from csv"
  task :customers => :environment do
    Customer.destroy_all
    filename = File.join Rails.root, "/csv/customers.csv"
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE CUSTOMERS RESTART IDENTITY")
     CSV.foreach(filename, headers: true) do |row|
     Customer.create({first_name: row["first_name"], last_name: row["last_name"]})
   end
 end

desc "Import invoice items from csv"
 task :invoice_items => :environment do
   InvoiceItem.destroy_all
   filename = File.join Rails.root, "/csv/invoice_items.csv"
   ActiveRecord::Base.connection.execute("TRUNCATE TABLE INVOICE_ITEMS RESTART IDENTITY")

   CSV.foreach(filename, headers: true) do |row|
     InvoiceItem.create({item_id: row["item_id"],
                         invoice_id: row["invoice_id"],
                         quantity: row["quantity"],
                         unit_price: (row["unit_price"]).to_f/100})
   end
 end

 desc "Import invoices from csv"
  task :invoices => :environment do
    Invoice.destroy_all
    filename = File.join Rails.root, "/csv/invoices.csv"
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE INVOICES RESTART IDENTITY")
    CSV.foreach(filename, headers: true) do |row|
      Invoice.create({customer_id: row["customer_id"],
                      merchant_id: row["merchant_id"],
                      status: row["status"]})
    end
  end

  desc "Import items from csv"
   task :items => :environment do
     Item.destroy_all
     filename = File.join Rails.root, "/csv/items.csv"
     ActiveRecord::Base.connection.execute("TRUNCATE TABLE ITEMS RESTART IDENTITY")
     CSV.foreach(filename, headers: true) do |row|
       Item.create({name: row["name"],
                    description: row["description"],
                    unit_price: (row["unit_price"]).to_f/100,
                    merchant_id: row["merchant_id"]})
     end
   end

   desc "Import merchants from csv"
    task :merchants => :environment do
      Merchant.destroy_all
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE MERCHANTS RESTART IDENTITY")
      filename = File.join Rails.root, "/csv/merchants.csv"
      CSV.foreach(filename, headers: true) do |row|
        Merchant.create({name: row["name"]})
      end
    end

    desc "Import transactions from csv"
     task :transactions => :environment do
       Transaction.destroy_all
       ActiveRecord::Base.connection.execute("TRUNCATE TABLE TRANSACTIONS RESTART IDENTITY")
       filename = File.join Rails.root, "/csv/transactions.csv"
       CSV.foreach(filename, headers: true) do |row|
         Transaction.create({invoice_id: row["invoice_id"],
                             credit_card_number: row["credit_card_number"],
                             credit_card_expiration_date: (row["credit_card_expiration_date"]),
                             result: row["result"]})
       end
     end

end

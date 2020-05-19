require 'csv'

# Dir.glob("#{Rails.root}/app/models/*.rb").each { |file| require file }

# Customer.delete_all
# InvoiceItem.delete_all
namespace :import do

desc "All"
   task all: [:restart, :merchants, :items, :customers, :invoices, :invoice_items, :transactions]

 desc "Truncate all tables in the database"
   task :restart => :environment do
       ActiveRecord::Base.connection.tables.each do |table|
          next if table == "schema_migrations"
           ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE;")
        end
    end

desc "Import customers from csv"
  task :customers => :environment do
    filename = File.join Rails.root, "/csv/customers.csv"
     CSV.foreach(filename, headers: true) do |row|
     Customer.create({first_name: row["first_name"], last_name: row["last_name"], created_at: row["created_at"], updated_at: row["updated_at"]})
   end
 end

desc "Import invoice items from csv"
 task :invoice_items => :environment do
   filename = File.join Rails.root, "/csv/invoice_items.csv"
   CSV.foreach(filename, headers: true) do |row|
     InvoiceItem.create({item_id: row["item_id"],
                         invoice_id: row["invoice_id"],
                         quantity: row["quantity"],
                         unit_price: (row["unit_price"]).to_f/100,
                         created_at: row["created_at"],
                         updated_at: row["updated_at"]})
   end
 end

 desc "Import invoices from csv"
  task :invoices => :environment do
    filename = File.join Rails.root, "/csv/invoices.csv"
    CSV.foreach(filename, headers: true) do |row|
      Invoice.create({customer_id: row["customer_id"],
                      merchant_id: row["merchant_id"],
                      status: row["status"],
                      created_at: row["created_at"],
                      updated_at: row["updated_at"]})
    end
  end

  desc "Import items from csv"
   task :items => :environment do
     filename = File.join Rails.root, "/csv/items.csv"
     CSV.foreach(filename, headers: true) do |row|
       Item.create({name: row["name"],
                    description: row["description"],
                    unit_price: (row["unit_price"]).to_f/100,
                    merchant_id: row["merchant_id"],
                    updated_at: row["updated_at"],
                    created_at: row["created_at"]})

     end
   end

   desc "Import merchants from csv"
    task :merchants => :environment do
      filename = File.join Rails.root, "/csv/merchants.csv"
      CSV.foreach(filename, headers: true) do |row|
        Merchant.create({name: row["name"],
                         created_at: row["created_at"],
                         updated_at: row["updated_at"]})
      end
    end

    desc "Import transactions from csv"
     task :transactions => :environment do
       filename = File.join Rails.root, "/csv/transactions.csv"
       CSV.foreach(filename, headers: true) do |row|
         Transaction.create({invoice_id: row["invoice_id"],
                             credit_card_number: row["credit_card_number"],
                             credit_card_expiration_date: (row["credit_card_expiration_date"]),
                             result: row["result"],
                             created_at: row["created_at"],
                             updated_at: row["updated_at"]})
       end
     end

end

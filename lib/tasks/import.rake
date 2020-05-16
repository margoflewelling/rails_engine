require 'csv'

# Dir.glob("#{Rails.root}/app/models/*.rb").each { |file| require file }

# Customer.delete_all
# InvoiceItem.delete_all
namespace :import do

desc "Import customers from csv"
  task :customers => :environment do
    filename = File.join Rails.root, "/csv/customers.csv"
     CSV.foreach(filename, headers: true) do |row|
     Customer.create(row.to_h)
   end
 end

desc "Import invoice items from csv"
 task :invoice_items => :environment do
   filename = File.join Rails.root, "/csv/invoice_items.csv"
   CSV.foreach(filename, headers: true) do |row|
     InvoiceItem.create(row.to_h)
   end
 end

 desc "Import invoices from csv"
  task :invoices => :environment do
    filename = File.join Rails.root, "/csv/invoices.csv"
    CSV.foreach(filename, headers: true) do |row|
      Invoice.create(row.to_h)
    end
  end

  desc "Import items from csv"
   task :items => :environment do
     filename = File.join Rails.root, "/csv/items.csv"
     CSV.foreach(filename, headers: true) do |row|
       Item.create(row.to_h)
     end
   end

   desc "Import merchants from csv"
    task :merchants => :environment do
      filename = File.join Rails.root, "/csv/merchants.csv"
      CSV.foreach(filename, headers: true) do |row|
        Merchant.create(row.to_h)
        require "pry"; binding.pry
      end
    end

    desc "Import transactions from csv"
     task :transactions => :environment do
       filename = File.join Rails.root, "/csv/transactions.csv"
       CSV.foreach(filename, headers: true) do |row|
         Transaction.create(row.to_h)
         require "pry"; binding.pry
       end
     end

end

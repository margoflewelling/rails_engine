# README

How to get RailsEngine started:

* Ruby version: 2.5.3

* Configuration:  Bundle install

* Database creation:  Run: rails db:create
                           rails db:migrate
                           rake task:all     -- to import csv files into the database


* How to run the test suite:  Bundle exec rspec, all api call testing is in the spec/requests folder

* Services
     Front end (Rails Driver) of this project lives here:
                    https://github.com/turingschool-examples/rails_driver
     Rails Engine builds a commerce api for rails driver to use.
     Rails engine has the following paths built in:

        All crud functionality for both Merchants and Items
        Find 1 or multiple Merchants or Items through query params
             GET api/v1/merchants/find?name=ring&description=capitol
        Returns merchants with most revenue
             GET /api/v1/merchants/most_revenue?quantity=x
        Returns merchants with most items sold
             GET /api/v1/merchants/most_items?quantity=x
        Returns all revenue generated between two dates
             GET /api/v1/revenue?start=<start_date>&end=<end_date>
        Returns total revenue for a single merchant
             GET /api/v1/merchants/:id/revenue

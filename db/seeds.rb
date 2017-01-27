# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.delete_all
Product.delete_all
Category.create! id: 1, name: "Ovoce"
Category.create! id: 2, name: "Zelenina"
Category.create! id: 3, name: "Napoje"

Product.create! name: "Jablka", number: "APL-1", package: "1 kg", minimum_order: 1, price: 50, customer_price: 45, category_id: 1
Product.create! name: "Rajcata", number: "TOMAT-1", package: "1 kg", minimum_order: 1, price: 75, customer_price: 68, category_id: 2
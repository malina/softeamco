# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bittrex = Source.create(name: 'bittrex')
poloniex = Source.create(name: 'poloniex')

bittrex_client = BittrexClient.new

currencies = bittrex_client.currencies

currencies.each do |currency|
  name, long_name = currency["Currency"], currency["CurrencyLong"]
  Currency.create(name: name, long_name: long_name, source: bittrex)
end

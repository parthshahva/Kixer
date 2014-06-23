require_relative 'backend.rb'

db = Kixer.db
db.import_csv("csv/training.csv")
response = nil
until response == 'exit'
  puts "Waiting for standard incoming ad request"
  response = gets.chomp
  inputs = response.split(',')
  ad = db.get_ad(inputs)
  puts ad
end

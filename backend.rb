require 'csv'
require 'pry'
module Kixer
  class InMemory
    attr_accessor :south_america, :europe, :north_america, :africa, :australia, :asia
    def initialize
      @south_america = {}
      @europe = {}
      @north_america = {}
      @africa = {}
      @australia = {}
      @asia = {}
    end

    def import_csv(file_path)
      csv = CSV.read(file_path)
      csv.each do |row|
        region = @south_america if row[5] == "South America"
        region = @europe if row[5] == "Europe"
        region = @asia if row[5] == "Asia"
        region = @north_america if row[5] == "North America"
        region = @africa if row[5] == "Africa"
        region = @australia if row[5] == "Australia"
        region[row[4]] = Hash.new if region[row[4]] == nil
        region[row[4]][row[2]] = [0,0,0] unless region[row[4]][row[2]].is_a?(Array)
        region[row[4]][row[2]][0] += 1
        region[row[4]][row[2]][1] += 1 if row[6].to_i == 1
        region[row[4]][row[2]][2] = (region[row[4]][row[2]][1].to_f/region[row[4]][row[2]][0] * 100).round
      end
    end

    def get_ad(input)
      region = @south_america if input[4] == "South America"
      region = @europe if input[4] == "Europe"
      region = @asia if input[4] == "Asia"
      region = @north_america if input[4] == "North America"
      region = @africa if input[4] == "Africa"
      region = @australia if input[4] == "Australia"
      ad = region[input[3]].sort_by { |system, stats| stats[2] }.last[0]
      CSV.open("csv/adsSent.csv", "a") do |csv|
        csv << [input[0], input[1], ad, input[2], input[3], input[4]]
      end
      ad
    end
  end
  def self.db
    @db || @db = InMemory.new
  end
end



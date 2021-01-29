months = {
    January: 31, February: [28, 29], March: 31, April: 30,
    May: 31, June: 30, July: 31, August: 31,
    Septmeber: 30, October: 31, November: 30, December: 31
  }

puts "List of months containing 30 days:"
puts months.select {|key, value| value == 30}.keys

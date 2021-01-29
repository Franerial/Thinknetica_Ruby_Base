puts "Введите день:"
day = gets.chomp.to_i
puts "Введите месяц:"
month = gets.chomp.to_i
puts "Введите год:"
year = gets.chomp.to_i

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days[1] += 1 if (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)

n = 0
(month - 1).times {|i| n+= days[i]}
n+= day

puts "Порядковый номер для равен: #{n}"
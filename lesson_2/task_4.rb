include Math

puts "Введите значение первого коэффициента a"
a = gets.chomp.to_f
puts "Введите значение второго коэффициента b"
b = gets.chomp.to_f
puts "Введите значение третего коэффициента c"
c = gets.chomp.to_f

d = (b**2) - 4*a*c 

if d > 0
    puts "Первый корень равен: #{(-b + sqrt(d))/(2*a)}"
    puts "Второй корень равен: #{(-b - sqrt(d))/(2*a)}"
elsif d == 0
    puts "Корень равен: #{-b/(2*a)}"
else
    puts "Корней нет"
end
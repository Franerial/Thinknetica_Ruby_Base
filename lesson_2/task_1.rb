puts "Введите ваше имя"
name = gets.chomp
name.capitalize!
puts "Введите ваш рост, см"
height = gets.chomp.to_i
perfect_weight = (height - 110) * 1.15

if perfect_weight < 0
    puts "#{name}, ваш вес уже оптимальный"
else
    puts "#{name}, ваш идеальный вес составляет: #{perfect_weight} кг"
end

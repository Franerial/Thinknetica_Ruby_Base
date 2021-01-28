puts "Введите длину первой стороны треугольника"
a = gets.chomp.to_f
puts "Введите длину второй стороны треугольника"
b = gets.chomp.to_f
puts "Введите длину третей стороны треугольника"
c = gets.chomp.to_f

side_a, side_b, longest_side = [a, b, c].sort

if [a, b, c].uniq.size == 1
    puts "Треугольник равносторонний и равнобедренный"
elsif (longest_side**2 == (side_a**2) + (side_b**2)) && ([a, b, c].uniq.size == 2)
    puts "Треугольник прямоугольный и равнобедренный"
elsif longest_side**2 == (side_a**2) + (side_b**2)
    puts "Треугольник прямоугольный"
elsif [a, b, c].uniq.size == 2
    puts "Треугольник равнобедренный"
else
    puts "Это обычный треугольник"
end


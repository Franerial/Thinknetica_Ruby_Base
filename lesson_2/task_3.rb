puts "Введите длину первой стороны треугольника"
a = gets.chomp.to_f
puts "Введите длину второй стороны треугольника"
b = gets.chomp.to_f
puts "Введите длину третей стороны треугольника"
c = gets.chomp.to_f

longest_side = [a,b,c].max
longest_side_pos = [a,b,c].index(longest_side)
other_sides = [a,b,c]
other_sides.delete_at(longest_side_pos) #exlude the longest side from array 

if [a, b, c].uniq.size == 1
    puts "Треугольник равносторонний и равнобедренный"
elsif longest_side**2 == (other_sides[0]**2) + (other_sides[1]**2)
    puts "Треугольник прямоугольный"
elsif [a, b, c].uniq.size == 2
    puts "Треугольник равнобедренный"
elsif (longest_side**2 == (other_sides[0]**2) + (other_sides[1]**2)) && ([a, b, c].uniq.size == 2)
    puts "Треугольник прямоугольный и равнобедренный"
else
    puts "Это обычный треугольник"
end


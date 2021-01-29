cart = {}
loop do
    puts "Введите название товара:"
    name = gets.chomp
    break if name == "stop"
    puts "Введите цену товара за одну единицу:"
    price = gets.chomp.to_f
    puts "Введите кол-во купленного товара:"
    quantity = gets.chomp.to_f
    cart[name] = {price: price, quantity: quantity}
end

puts "Полученный хэш:"
puts cart

h = cart.each_with_object({}) do |(key, value), hash|
    hash[key] = value[:price] * value[:quantity]
end

puts "Итоговая сумма за каждый товар:"
h.each {|key, value| puts "#{key} : #{value}"}

puts "Итоговая сумма всей корзины: #{h.values.sum}"

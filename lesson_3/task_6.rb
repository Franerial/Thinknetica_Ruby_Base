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

updated_cart = cart.each_with_object({}) do |(name, options), hash|
    hash[name] = options[:price] * options[:quantity]
end

puts "Итоговая сумма за каждый товар:"
updated_cart.each {|name, total_sum| puts "#{name} : #{total_sum}"}

puts "Итоговая сумма всей корзины: #{updated_cart.values.sum}"

def fibonacci(n)
    return 1 if (1..2).include? n
    fibonacci(n - 1) + fibonacci(n - 2)
end

arr_fibonacci = [0]
i = 1

while 100 > next_num = fibonacci(i)
    arr_fibonacci << next_num
    i += 1
end

puts "Числа Фибоначчи до 100:"
arr_fibonacci.each {|number| print "#{number} "}
puts 
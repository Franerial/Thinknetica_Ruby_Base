def fibonacci(n)
    return 1 if (1..2).include? n
    fibonacci(n - 1) + fibonacci(n - 2)
end

arr= [0]
i = 1
n = 100

loop do
    if arr.last >= n
        arr.pop
        break
    end
    arr << fibonacci(i)
    i += 1
end

puts "Числа Фибоначчи до #{n}:"
arr.each {|i| print "#{i} "}
puts 
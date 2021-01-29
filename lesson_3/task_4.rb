vowels = %w[a e i o u y]
alph = *('a'..'z')
h = {}
vowels.each {|i| h[i] = alph.index(i)}
puts "Искомый хэш:" 
puts h

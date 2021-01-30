vowels = %w[a e i o u y]
alph = *('a'..'z')
h = {}
vowels.each {|letter| h[letter] = alph.index(letter)}
puts "Искомый хэш:" 
puts h

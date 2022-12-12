def substrings(phrase, array)
    result = []
    phrase.downcase.split(" ").select do |word|
        array.select do |term|
            result.push(term) if word.include?(term)
        end
    end
    result.sort.tally
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

p substrings("Howdy partner, sit down! How's it going?", dictionary)
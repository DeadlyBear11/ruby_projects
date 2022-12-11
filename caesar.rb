def caesar_cipher(string, shift)
    new_string = ""
    string.chars.map do |char|
        char_loc = char.codepoints[0]
        #Handle last characters of the alphabet
        if char_loc + shift > 122 #for lowercase
            new_char_loc = char_loc - 26 + shift
        elsif char_loc <= 90 && char_loc + shift > 90 #for uppercase
            new_char_loc = char_loc - 26 + shift
        else
            new_char_loc = char_loc + shift
        end

        new_string.concat(new_char_loc.chr)
    end
    puts new_string
end

caesar_cipher("UVWxyz", 3)
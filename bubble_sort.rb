def bubble_sort(array)
    swapped = nil
    corrected = 0
    until swapped == 0 do
        swapped = 0
        corrected += 1
        array.each_index do |i|
            if i >= array.length - corrected
                next
            elsif array[i] > array[i + 1]
                array[i], array[i + 1] = array[i + 1], array[i]
                swapped += 1
            end
        end
    end
    array
end

numbers = [3,5,8,4,9,2,6,1,7]

p bubble_sort(numbers)
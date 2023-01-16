def merge_sort(array)
  if array.length < 2
    array
  else
    left = merge_sort(array[0...array.length / 2])
    right = merge_sort(array[array.length / 2...array.length])
    merge(left, right)
  end
end

def merge(left, right, array = [])
  (left.length + right.length).times do
    if left.empty?
      array.push(right.shift)
    elsif right.empty?
      array.push(left.shift)
    else
      comparison = left <=> right
      array << case comparison
               when -1
                 left.shift
               when 1
                 right.shift
               else
                 left.shift
               end
    end
  end
  array
end

arr = []
rand(10).times do
  arr.push(rand(200))
end

p merge_sort(arr)

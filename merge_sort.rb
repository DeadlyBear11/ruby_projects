def merge_sort(arr)
  return unless arr.length > 1

  if arr.length.even?
    arr_left = arr[0..((arr.length / 2) - 1)]
    arr_right = arr[(arr.length / 2)..]
  else
    arr_left = arr[0..((arr.length - 2) / 2)]
    arr_right = arr[((arr.length - 1) / 2)..]
  end

  merge_sort(arr_left)
  merge_sort(arr_right)

  arr_sorted = []
  idx_sorted = 0
  idx_left = 0
  idx_right = 0

  while idx_left <= arr_left.length - 1 && idx_right <= arr_right.length - 1
    if arr_left[idx_left] < arr_right[idx_right]
      arr_sorted[idx_sorted] = arr_left[idx_left]
      idx_left += 1
    else
      arr_sorted[idx_sorted] = arr_right[idx_right]
      idx_right += 1
    end
    idx_sorted += 1
  end
end

test_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]

merge_sort(test_arr)

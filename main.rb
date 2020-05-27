def bubble_sort(arr)
  i = 0
  for i in 0..(arr.length - 2)
        next if arr[i] > arr[i + 1]
            temp = arr[i]
            arr[i] = arr[i + 1]
            arr[i + 1] = temp
        end
  end
  return arr
    end


def bubble_sort_by(array)
  loop_size = array.length
  loop do
    swap = false
    (loop_size - 1).times do |i|
      next unless yield(array[i], array[i + 1]).positive?

      array[i], array[i + 1] = array[i + 1], array[i]
      swap = true
    end
    break unless swap
  end
  array
end

puts bubble_sort([3, 1, 7])
puts bubble_sort_by(%w[hi hello super hey hooy A]) { |left, right| left.length <=> right.length }

    
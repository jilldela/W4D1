# O(n^2)
def bad_two_sum?(arr, target)
  arr.each_index do |idx1|
    (idx1+1).upto(arr.length-1) do |idx2|
      return true if arr[idx1] + arr[idx2] == target
    end
  end
  false
end

# O(n log n)
def better_two_sum?(arr, target)
  arr.sort!
  # example target = 5
  i, j = 0, arr.length - 1
  until i == j
    if arr[i] + arr[j] == target
      return true
    elsif arr[i] + arr[j] > target
      j -= 1
    else
      i += 1
    end
  end
  false
end

# O(n)
def best_two_sum?(arr, target)
  hash = {}
  arr.each do |ele|
    return true if hash[ele]
    hash[target - ele] = ele
  end
  false
end

arr = [0, 1, 5, 7]
p best_two_sum?(arr, 6) # => should be true
p best_two_sum?(arr, 10) # => should be false

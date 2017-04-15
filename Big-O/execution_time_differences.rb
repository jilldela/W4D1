#O(n^2)
def my_min_slow(list)
  min = list.first
  list.each do |el1|
    min = el1 if list.all? { |el2| el2 >= el1 }
  end
  min
end

#O(n)
def my_min_fast(list)
  min = list.first
  list.each do |el|
    min = el if el < min
  end
  min
end

#O(n^3)
def sub_sum_slow(list)
  subarrays = []
  list.each_index do |idx1|
    idx1.upto(list.length-1) do |idx2|
      subarrays << list[idx1..idx2]
    end
  end
  subarrays.map { |subarr| subarr.reduce(:+) }.max
end

#O(n)
def sub_sum_fast(list)
  record = 0
  highest = list.first
  list.each do |ele|
    record += ele
    highest = record if record > highest
    record = 0 if record < 0
  end
  highest > 0 ? highest : list.max
end


a = [2, 3, -6, 7, -6, 7]
p  sub_sum_fast(a)
b = [1,2,-5,-2]
p  sub_sum_fast(b)
c = [-5, -1, -3]
p sub_sum_fast(c)
d = [1, 6 , 9, 0]
p sub_sum_fast(d)
e = [1,2,-5,-2,100]
p sub_sum_fast(e)

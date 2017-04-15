
#O(n*n!)
def first_anagram?(str1, str2)
  perms = str1.chars.permutation.map(&:join)
  perms.include?(str2)
end

#O(n^2)
def second_anagram?(str1, str2)
  str1_chars = str1.chars
  str2_chars = str2.chars
  idx = 0
  while idx < str1.length
    if str2_chars.include?(str1_chars[idx])
      str2_chars.delete(str1_chars[idx])
    end
    idx += 1
  end

  str2_chars.empty?
end

#O(nlogn)
def third_anagram?(str1, str2)
  str1.chars.sort == str2.chars.sort
end

#O(n)
def four_anagram?(str1, str2)
  hash1 = Hash.new(0)

  str1.each_char { |char| hash1[char] += 1 }
  str2.each_char { |char| hash1[char] -= 1 }

  hash1.none? { |k,v| v != 0 }
end

p four_anagram?("gizmo", "sally")
p four_anagram?("elvis", "lives")

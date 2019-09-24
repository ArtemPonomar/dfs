require "minitest/autorun"

def find_parts(string, substrings)
  return dfs(string, substrings, Array.new, Array.new(1,0))
end

def dfs(string, substrings, found, skip)
  return found if string.size == 0 # recursion exit condition

  variants = Array.new
  substrings.each do |sub|
    variants << sub if string.index(sub) == 0 # finding all possible beginnings of the string
  end

  current_skip = skip[-1]

  if current_skip < variants.size # if can, go deeper
    new_found = found.push(variants[current_skip])
    new_string = string
    new_string.slice!(new_found[-1])
    new_skip = skip << 0
    return dfs(new_string, substrings, new_found, new_skip) # going deeper

  else # if can't go deeper, go backwards
    return nil if found.size == 0 # return null, if couldn't find any variants
    reversed_string = found.last + string
    reversed_found = found
    reversed_found.delete_at(-1)
    reverse_skip = skip
    reverse_skip.delete_at(-1)
    reverse_skip[-1] += 1
    return dfs(reversed_string, substrings, reversed_found, reverse_skip) # going backwards
  end
end

class Test < Minitest::Test
  def test_trap
    assert_equal ["da", "aa"], find_parts("daaa", ["daa", "da", "aa"])
  end
  def test_hard
    assert_equal ["1", "2", " ", "2", "1", " ", "3", "1", "1", "2"], find_parts("12 21 3112", [" ", "1", '2', "3"])
  end
  def test_false
    assert_nil find_parts("daaa", ["daa", "aa"])
  end
end

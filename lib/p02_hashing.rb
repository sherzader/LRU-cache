class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0 if empty?
    sum = 0
    each_with_index do |el, i|
      sum += el * i
    end
    sum
  end
end

class String
  def hash
    sum = 0
    chars.each_with_index do |el, i|
      sum += el.ord * i
    end
    sum
  end
end

class Hash
  def hash
    sum = 0
    string_h = sort_by{|k,v| k}.flatten.map(&:to_s)
    string_h.each_with_index do |el, i|
      sum += el.ord * i
    end
    sum
  end
end

a = {a: "a"}
b = {a: "a", b: "b"}
p a.hash
p b.hash

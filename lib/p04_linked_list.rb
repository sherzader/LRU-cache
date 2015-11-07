require 'byebug'
class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.to_s
  end

  def last
    current = @head
    until current.next.nil?
      current = current.next
    end
    current
  end

  def empty?
    @head.nil?
  end

  def get(key)
    current = @head
    until current.nil?
      if current.key == key
        return current.val
      end
      current = current.next
    end
  end

  def include?(key)
    current = @head
    until current.nil?
      return true if current.key == key
      current = current.next
    end
    false
  end

  def insert(key, val)
    if @head.key.nil? && @head.val.nil?
      @head = Link.new(key, val)
      return
    end

    current = @head
    loop do
      if current.next.nil?
        current.next = Link.new(key, val)
        break
      end
      current = current.next
    end
  end

  def remove(key)
    current = @head
    if current.key == key
      @head = current.next
    end
    until current.nil?
      prev = current
      if current.key == key
        prev.next = current.next
      end
      current = current.next
    end
  end

  def each
    current = @head
    until current.nil?
      yield current
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

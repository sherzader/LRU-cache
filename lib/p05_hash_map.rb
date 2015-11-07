require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket = key.hash % num_buckets
    bucket_array = @store[bucket]
    bucket_array.each do |x|
      return true if x.key == key
    end
    false
  end

  def set(key, val)
    resize! if @store.length == @count

    @store[key.hash % num_buckets].insert key, val
    @count += 1
  end

  def get(key)
    @store[key.hash % num_buckets]
  end

  def delete(key)
  end

  def each
    # current = @head
    # until current.nil?
    #   yield current
    #   current = current.next
    # end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end

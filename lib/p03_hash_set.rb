require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    # return nil if key.is_a?(Array) && key.empty?
    if key.empty?
      @store << key
      @count +=1
      return
    end
    resize! if @store.length == @count

    @store[key.hash % num_buckets] << key
    @count += 1
  end

  def include?(key)
    bucket = key.hash % num_buckets
    bucket_array = @store[bucket]
    !bucket_array.find { |x| x == key }.nil?
  end

  def remove(key)
    bucket = key.hash % num_buckets
    bucket_array = @store[bucket]
    bucket_array.delete_at(bucket_array.index(key))
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    new_num_bucks = new_store.length
    @store.flatten.each do |num|
      new_store[num.hash % new_num_bucks] << num
    end

    @store = new_store
  end
end


require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @store.length && num > 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num
  end

  def remove(num)
    bucket = num % num_buckets
    bucket_array = @store[bucket]
    bucket_array.delete_at(bucket_array.index(num))
  end

  def include?(num)
    bucket = num % num_buckets
    bucket_array = @store[bucket]
    !bucket_array.find { |x| x == num }.nil?
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`

  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @store.length == @count

    bucket = num % num_buckets
    @store[bucket] << num
    @count += 1
  end

  def remove(num)
    bucket = num % num_buckets
    bucket_array = @store[bucket]
    bucket_array.delete_at(bucket_array.index(num))
  end

  def include?(num)
    bucket = num % num_buckets
    bucket_array = @store[bucket]
    !bucket_array.find { |x| x == num }.nil?
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize! #double @store's num_buckets
    new_store = Array.new(num_buckets * 2) { Array.new }
    new_num_bucks = new_store.length
    @store.flatten.each do |num|
      new_store[num % new_num_bucks] << num
    end

    @store = new_store
  end
end

# set1 = ResizingIntSet.new
# set1.insert(1)
# set1.insert(2)
# set1.insert(3)
# set1.insert(4)
# p set1.include? 4

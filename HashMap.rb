class HashMap
  
  attr_reader :capacity

  def initialize(
    @load_factor = 0,75
    @capacity = 16
    @buckets = Array.new(@capacity)
  )
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
        
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
        
    hash_code
  end
  
  def set(key, value)
    hash_code = hash(key)
    bucket_index = hash_code % @capacity
    bucket = @buckets[bucket_index]

    found = false

    bucket.each  do |pair| 
      if pair[0] == key
        pair[1] = value
        found = true
      end
    end
    unless found
      bucket << [key,value]
    end
    
    if length > (@capacity * @load_factor)
      resize
    end
  end

  def get(key)
    hash_code = hash(key)
    bucket_index = hash_code % capacity
    bucket = @buckets[bucket_index]

    bucket.each do |k, v|
      return v if k == key
    end
    return nil
  end

  def has?(key)
    hash_code = hash(key)
    bucket_index = hash_code % capacity
    bucket = @buckets[bucket_index]

    bucket.each do |k|
      return true if k == key
    end
    return false
  end

  def remove(key)
    hash_code = hash(key)
    bucket_index = hash_code % capacity
    bucket = @buckets[bucket_index]

      bucket.each_with_index do |k, index|
      if k[0] == key
        removed_value = k[1]
        bucket.delete_at(index)
        return removed_value
      end
    end
    nil
  end

  def length
    i = 0
    @buckets.each do |bucket|
      pairs = bucket.length
        i += pairs
    end
    return i
  end

  def clear
    @capacity = 16
    @buckets = Array.new(@capacity)
  end

  def keys
    k = Array.new()

    @buckets.each do |bucket|
      bucket.each do |pair|
        k << pair[1]
      end
    end
    return k
  end

  def entries
    pairs = []
    
    @buckets.each do |bucket|
      bucket.each do |pair|
        pairs << pair
      end
    end
    return pairs
  end



  private

  def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }

    old_buckets.each do |bucket|
      bucket.each do |key, value|
        set(key, value)
      end
    end
  end


end
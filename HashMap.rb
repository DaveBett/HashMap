class HashMap
  def initialize(
    @load_factor = 0,75
    @capacity = 16
  )

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
end
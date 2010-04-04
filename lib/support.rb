module Enumerable
  def collisions( &block )
    had_no_block = !block
    block ||= lambda { |item| item }
    result = Hash.new { |hash, key| hash[key] = Array.new }
    self.each do |item|
      key = block.call(item)
      result[key] << item
    end
    result.reject! do |key, values|
      values.size <= 1
    end
    #return had_no_block ? result.values.flatten : result
    return result
  end
end

module ActiveRecord
  class Errors
    def to_hash
      returning({}) do |result|
        self.to_a.each do |entry|
          field,message = entry
          result[field.to_sym] = message
        end
      end
    end
  end
end

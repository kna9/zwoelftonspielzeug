# encoding: UTF-8

module ObservableAccessor
  def self.included(klass)    
    klass.extend ClassMethods
  end
  module ClassMethods
    # NOTE We don't check if a value has really changed here.
    def observable_accessor(ace)
      attr_accessor ace
      define_method("#{ace}=") { |new_value|
        instance_variable_set("@#{ace}", new_value)
        changed
        notify_observers(self, :update, ace.to_sym => new_value)
      }
    
    end
  end
end

class Array    
  # Taken from ActiveSupport   
  def in_groups(number, fill_with = nil)
    # size / number gives minor group size;
    # size % number gives how many objects need extra accomodation;
    # each group hold either division or division + 1 items.
    division = size / number
    modulo = size % number

    # create a new array avoiding dup
    groups = []
    start = 0

    number.times do |index|
      length = division + (modulo > 0 && modulo > index ? 1 : 0)
      padding = fill_with != false &&
        modulo > 0 && length == division ? 1 : 0
      groups << slice(start, length).concat([fill_with] * padding)
      start += length
    end

    if block_given?
      groups.each { |g| yield(g) }
    else
      groups
    end
  end
  
  
  # rotate clockwise (right)
  def rotate_right!(num=1)
    num.times{ self.unshift self.pop }
    self
  end
  
  # def rotate_right(num=1)
  #   dup.rotate_right!(num)
  # end
end
module Crotest
  class AssertionFailed < Exception
    getter file
    getter line

    def initialize(message, @file, @line)
      super(message)
    end
  end
end

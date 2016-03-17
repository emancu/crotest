require "./tests"

module Crotest::DSL
  def describe(name, file = __FILE__, line = __LINE__, &block)
    block.call
  end

  def it(name : String, file = __FILE__, line = __LINE__, &block)
    block.call
  rescue exception : Crotest::AssertionFailed
    result = Crotest::FailedTest.new name, file, line, exception
  rescue exception : Exception
    result = Crotest::ErroredTest.new name, file, line, exception
  ensure
    result ||= Crotest::PassedTest.new name, file, line

    Crotest.report result
  end

  def pending(name : String, file = __FILE__, line = __LINE__)
    Crotest.report Crotest::PendingTest.new(name, file, line)
  end

  def pending(name : String, file = __FILE__, line = __LINE__, &block)
    pending name, file, line
  end
end

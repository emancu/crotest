module Crotest::Assertions
  # Assert that value is not nil or false.
  macro assert(expression, msg = nil, file = __FILE__, line = __LINE__)
    %evaluation = {{ expression }}

    unless %evaluation
      %msg = {{msg}} || "Failed assertion"

      raise Crotest::AssertionFailed.new(%msg, {{file}}, {{line}})
    end

    print "."
    Crotest.increment(:assertions)
  end

  macro deny(expression, msg = nil, file = __FILE__, line = __LINE__)
    assert !expression, msg, file, line
  end

  # Assert that actual and expected values are equal.
  def assert_equal(expected, actual)
    assert(actual == expected, "#{actual.inspect} != #{expected.inspect}")
  end

  # Assert that the block raises an expected exception.
  macro assert_raise(expected = Exception)
    begin
      yield
    rescue exception : {{expected}}

    else
      # assert(exception.kind_of?(expected), "got #{exception.inspect} instead")
    end
  end
end

module Crotest::Assertions
  # Assert that expression is not nil or false.
  macro assert(expression, msg = nil, file = __FILE__, line = __LINE__)
    %evaluation = {{expression}}

    unless %evaluation
      %msg = {{msg}} || "Failed assertion"

      raise Crotest::AssertionFailed.new(%msg, {{file}}, {{line}})
    end

    success
  end

  # Assert that expression is falsey
  macro deny(expression, msg = nil, file = __FILE__, line = __LINE__)
    assert !{{expression}}, {{msg}}, {{file}}, {{line}}
  end

  # Assert that actual and expected values are equal.
  macro assert_equal(expected, actual, msg = nil, file = __FILE__, line = __LINE__)
    %msg = {{msg}} || "#{ ({{expected}}).inspect } != #{ ({{actual}}).inspect }"
    assert({{expected}} == {{actual}}, %msg, {{file}}, {{line}})
  end

  # Assert that the block raises an expected exception.
  macro assert_raise(expected = Exception, msg = nil, file = __FILE__, line = __LINE__)
    begin
      {{yield}}
    rescue %exception : {{expected}}
      success
    rescue %exception
      %result = %exception.is_a?({{expected}})
      assert(%result, "got #{%result.inspect} instead", {{file}}, {{line}})
    else
      %msg = {{msg}} || "Expected #{{{expected}}.class.name} to be raised"
      raise Crotest::AssertionFailed.new(%msg, {{file}}, {{line}})
    end
  end

  private def success
    Crotest.increment(:assertions)
    print "."
  end
end

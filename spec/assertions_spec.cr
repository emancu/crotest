require "./spec_helper"

class DummyException < Exception
end

describe "Assertions" do
  describe "assert" do
    it "succeeds if the value is true" do
      assert true
    end

    it "raises if the assertion fails" do
      assert_raise(Crotest::AssertionFailed) { assert false }
    end
  end

  describe "deny" do
    it "succeeds if the value is false" do
      deny false
    end

    it "raises if the assertion fails" do
      assert_raise(Crotest::AssertionFailed) { deny true }
    end
  end

  describe "assert_equal" do
    it "should pass if both arguments are equal" do
      assert_equal 1, 1
    end

    it "should fail if both arguments are different" do
      assert_raise(Crotest::AssertionFailed) { assert_equal 1, 0 }
    end
  end

  describe "assert_raise" do
    describe "without specifying an exception class" do
      it "should pass if the code block raises an exception of any kind" do
        assert_raise { raise "Boom!" }
      end

      it "should fail if the code block does not raise any exceptions" do
        assert_raise(Crotest::AssertionFailed) { assert_raise { } }
      end
    end

    describe "using a specific exception" do
      it "should pass if the code block raises that exception" do
        assert_raise(DummyException) { raise DummyException.new }
      end

      it "should fail if the code block does not raise any exceptions" do
        assert_raise(Crotest::AssertionFailed) { assert_raise { } }
      end

      it "should fail if the code block raises an exception different than the one it was specified" do
        assert_raise(Crotest::AssertionFailed) { assert_raise(DummyException) { raise Exception.new } }
      end

      it "returns the exception object" do
        generic_error = assert_raise { raise DummyException.new("Boom!") }
        assert_equal DummyException, generic_error.class
        assert_equal "Boom!", generic_error.to_s

        specific_error = assert_raise(DummyException) { raise DummyException.new("Boom!") }
        assert_equal DummyException, specific_error.class
        assert_equal "Boom!", specific_error.to_s
      end
    end
  end
end

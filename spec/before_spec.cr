require "./spec_helper"

executions = [] of Int32

before do
  executions = [0]
end

it "only executes the before on top" do
  assert_equal [0], executions
end

describe "defines a scoped context for the inner block" do
  before do
    executions.push 1
  end

  it "run all the befores" do
    assert_equal [0, 1], executions
  end

  it "runs from the scratch every time" do
    assert_equal [0, 1], executions
  end

  describe "there is no limit for nested scopes" do
    before do
      executions.push 2
    end

    it "just works" do
      assert_equal [0, 1, 2], executions
    end
  end
end

describe "defines another scope sharing no nested contexts" do
  before do
    executions.push 200
  end

  it "run the scoped befores only" do
    assert_equal [0, 200], executions
  end
end

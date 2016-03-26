require "./spec_helper"

executions = [] of Int32

after do
  executions.push 1
end

it "is executed after the execution of this test" do
  assert executions.empty?
end

it "was executed once already" do
  assert_equal [1], executions
end

describe "will run the after blocks in reverse order" do
  after do
    executions.push 2
  end

  it "adds a 2 after this test is executed" do
    assert_equal [1, 1], executions
  end

  it "run all the afters in reverse order" do
    assert_equal [1, 1, 2, 1], executions
  end

  describe "there is no limit for nested scopes" do
    after do
      executions.push 3
    end

    it "adds a 3 after this test is executed" do
      assert_equal [1, 1, 2, 1, 2, 1], executions
    end

    it "just works" do
      assert_equal [1, 1, 2, 1, 2, 1, 3, 2, 1], executions
    end
  end
end

executions = [] of Int32

describe "defines another scope sharing no nested contexts" do
  after do
    executions.push 200
  end

  it "adds a 200 after the execution of this test" do
    assert executions.empty?
  end

  it "run the scoped afters only" do
    assert_equal [200, 1], executions
  end
end

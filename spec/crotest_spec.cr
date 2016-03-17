require "./spec_helper"

describe "Is not necessary" do
  it "should raise an error" do
    assert(raise "emancu")
  end

  it "evaluando" do
    cacho = 5 * 3

    assert cacho == 15
    assert cacho != 16
  end

  it "tests assert_equals" do
    assert_equal 15, 14
  end

  it "fail the assertion" do
    assert true == false
  end

  pending "I know is pending"
end

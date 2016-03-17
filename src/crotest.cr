require "./crotest/*"

module Crotest
  @@counters : Hash(Symbol, Int32)
  @@counters = {
    passed:     0,
    assertions: 0,
    failures:   0,
    errors:     0,
    pending:    0,
  }

  def self.increment(key : Symbol)
    @@counters[key] += 1
  end

  @@results_list : Array(Test)
  @@results_list = [] of Test

  def self.report(result : Test)
    @@results_list.push result
  end

  def self.print_report
    counters_str = @@counters.map { |k, v| "#{v} #{k}" }
    puts "\n", counters_str.join(", ")

    @@results_list.each &.present
  end

  def self.succeeded?
    @@counters[:errors] + @@counters[:failures] == 0
  end
end

at_exit do
  Crotest.print_report
  exit 1 unless Crotest.succeeded?
end

include Crotest::DSL
include Crotest::Assertions

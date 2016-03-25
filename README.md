# crotest
[![Build Status](https://travis-ci.org/emancu/crotest.svg?branch=master)](https://travis-ci.org/emancu/crotest)

A tiny and simple test framework for Crystal with common assertions and no pollution into `Object` class.

## Example

```crystal
require "crotest"

describe "DSL" do
  it "defines small test cases" do
    assert true
  end

  describe "nested describes for a better readability" do
    it "has only a few assertions" do
      var = false

      deny var
      assert_equal false, var
      assert_raise Exception do
        raise Exception.new("Boom!")
      end
    end
  end

  pending "tests are defined without a block"

  pending "tests can also be defined with a block, which will not be executed" do
    fail "This won't be executed :)"
  end
end
```

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  crotest:
    github: emancu/crotest
```

## Usage

```crystal
require "crotest"
```

Run your tests with `crystal spec`.

### Assertions

- `assert`
- `deny`
- `assert_equal`
- `assert_raise`

### Custom assertions

Extend the asssertions used by `Crotest` is really easy.
You need to open the module `Crotest::Assertions` and add your assertions like the example below:


```crystal
require "crotest"

module Crotest::Assertions
  macro assert_greater_than_4(value, file = __FILE__, line = __LINE__)
    assert {{value}} > 4, "#{{{value}}} <= 4", {{file}}, {{line}}
  end
end


it "supports my custom assertion" do
  assert_greater_than_4 5
end
```


## Contributing

1. Fork it ( https://github.com/emancu/crotest/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [emancu](https://github.com/emancu) Emiliano Mancuso - creator, maintainer

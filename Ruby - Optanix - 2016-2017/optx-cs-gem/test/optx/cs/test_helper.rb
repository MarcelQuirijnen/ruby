$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'optx/cs'
require 'minitest/autorun'
require 'minitest/reporters'

ENV['RACK_ENV'] = 'test'

Minitest::Reporters.use!

module Minitest::Assertions
   def assert_nothing_raised(*)
      yield
   end
end
gem 'minitest', '~> 5.4'
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'

require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'minitest/mock'
require 'test_helper'

class SymbolizeAttributeTest < ActiveSupport::TestCase

  class DummyObject
    extend SymbolizeAttribute
    symbolize_attribute :testing
  end

  test 'setting attribute' do
    dummy = DummyObject.new
    dummy.expects(:write_attribute).with(:testing, "symbol")
    dummy.testing = :symbol
  end

  test 'reading attribute' do
    dummy = DummyObject.new
    dummy.expects(:read_attribute).with(:testing).returns("string")
    assert_equal :string, dummy.testing
  end

  test 'reading nil attribute' do
    dummy = DummyObject.new
    dummy.expects(:read_attribute).with(:testing).returns(nil)
    assert_nil dummy.testing
  end

  test 'writing nil attribute' do
    dummy = DummyObject.new
    dummy.expects(:write_attribute).with(:testing, nil)
    dummy.testing = nil
  end

end


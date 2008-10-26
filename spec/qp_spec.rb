require File.dirname(__FILE__) + '/spec_helper'
require 'qp'

def assert_parses string, tokens, associations
  r_tokens, r_associations = QP::QueryParser.new.parse(string)
  r_associations.should == associations
  r_tokens.should == tokens
end
describe "qp" do
  it "should parse simple tokens" do
    assert_parses "a b c", %w[a b c], []
  end
  
  it "should parse quoted tokens" do
    assert_parses "'a is a' b 'c is c'", ["a is a", "b", "c is c"], []
  end
  
  it "should parse quoted tokens - double quotes" do
    assert_parses "\"a is a\" \"b is b\" c d", ["a is a", "b is b", "c", "d"], []
  end
  
  it "should parse a simple association" do
    assert_parses "a:b", [], [["a", "b"]]
  end
  
  it "should parse quoted associations" do
    assert_parses "a:'b'", [], [["a", "b"]]
  end
  
  it "should parse with everything!" do
    assert_parses "a:'b' \"is good\" tobe:GREAT even", ["is good", "even"], [["a", "b"],["tobe", "GREAT"]]
  end
end
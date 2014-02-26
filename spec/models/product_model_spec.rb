require 'spec_helper'

describe Product do 
    
  describe "validations" do    
# Basic Attribute Validations 
    it "must have a name" do
      expect(Product.new(:name => nil)).to be_invalid
    end

# Tests uniqueness of name, but doesn't dynamically come up with testing name
    it "has a unique name" do
      prod_one = Product.new(:name => 'Chocolate Macarons')
      prod_two = Product.new(:name => 'Chocolate Macarons')
      prod_one.name != prod_two.name
    end

    it "must have a price" do
      expect(Product.new(:price => nil)).to be_invalid
    end

# Association Validations
    it "should belong to a User" do
      t = Product.reflect_on_association(:user)
      t.macro.should == :belongs_to
    end
  end
end
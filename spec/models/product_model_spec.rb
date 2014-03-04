require 'spec_helper'

describe Product do

  let(:product) { create(:product) }

  describe "validations" do
     it 'is valid' do
      expect(product).to be_valid
    end

    it "must have a name" do
      product.update(name: nil)
      expect(product).to be_invalid
    end

    it "name should be unique" do
      product2 = build(:product, name: product.name)
      expect(product2).to_not be_valid
    end

    it "must have a price" do
      product.update(price: nil)
      expect(product).to be_invalid
    end

    it "must have a description" do
      product.update(description: nil)
      expect(product).to be_invalid
    end

    it "must have a weight" do
      product.update(weight: nil)
      expect(product).to be_invalid
    end

    it "must have a length" do
      product.update(length: nil)
      expect(product).to be_invalid
    end

    it "must have a height" do
      product.update(height: nil)
      expect(product).to be_invalid
    end

    it "must have a width" do
      product.update(width: nil)
      expect(product).to be_invalid
    end

  end
end
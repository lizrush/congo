FactoryGirl.define do
  factory :category do
    name "MyString"
  end

  factory :product_to_category_relationship do
    product_id 1
    category_id 1
  end

  factory :product do
    name "book"
    description "blabla"
    price 9.99
    image "string"
    stock 2
    weight 13
    height 3
    width 4
    length 6
  end
end
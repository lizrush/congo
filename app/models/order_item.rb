class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

# Validations
  validates :quantity,   presence: true,
                         numericality: { only_integer: true },
                         numericality: { :greater_than => 0 }

  def subtotal
    quantity * product.price
  end

end

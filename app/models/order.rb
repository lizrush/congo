class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  #To do -> figure out how to validate association presence w/out breaking save
  #validates :order_item, presence: true
  has_many :products, through: :order_items

  validates_presence_of :email, :name_on_cc, :cc_number, :cc_expiration, :cc_cvv, :billing_zip, :street_address, :city, :state, :country, if: :iscompleted?
  #http://edgeguides.rubyonrails.org/active_record_validations.html#using-a-symbol-with-if-and-unless

  #Validation still broken -> Kerri is researching.

  def iscompleted?
    status == "completed"
  end

  # TO FIX: this validation causes a new order to crash because it asks for this info before the payment/checkout page.

  # Would a separate checkout model be better?

  # scope :pending, -> { where(pending: true) }

  def subtotals
    order_items.reduce
  end


end

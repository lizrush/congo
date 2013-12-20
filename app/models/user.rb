class User < ActiveRecord::Base


  SALT = '$2a$10$D1OPM3Botcp0vU1sfbvlq.'

# attr_accessible :name, :email, :password, :password_confirmation

  before_save { self.email = self.email.downcase }
  before_create :create_remember_token
  before_create :encrypt_password
  after_save :clear_password

  has_many :products
  has_many :orders
  has_one  :cart 
  has_many :checkout

# Validations
  validates :name,      presence: true,
                        uniqueness: true
  
  validates :email,     presence: true,
                        uniqueness: true

  # User authentication should take care of password validation automatically.

  validates :password,     presence: true,
                           confirmation: true

  #format { with: /^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{8,}$/ }
  #message: 'Password must contain at least one letter, one number, and 8 or more characters'

  
  validates :password_confirmation,   presence: true
  #validates_length_of :password, :in => 8..20, :on => :create

  # Create a new token for user
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  #Encrypt the user's token using SHA1
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # Authenticate my password
  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.password == BCrypt::Engine.hash_secret(password, SALT)
      user
    else
      nil
    end
  end

# This is how I think order_fulfillment would be set up, but keep getting current user errors.
  # def total_revenue(stat)
  #   total = 0
  #   Order.where(status: stat).each(|order|     # find all completed orders and for each
  #     order.order_item.each(|order_item|              # look through the order_items in that order
  #       if order_item.product.user==@current_user     # if any of them are products of mine/self - CURRENT USER BROKEN
  #         total = total + order_item.subtotal         # add that subtotal to my revenue
  #       )
  #     )
  # end

  # def revenue_by_status
  #   status = ["pending", "paid","completed","cancelled"]
  #   status.map(|stat|
  #     total = 0
  #     Order.where(status: stat).each(|order|          # find all completed orders and for each
  #     order.order_item.each(|order_item|              # look through the order_items in that order
  #       if order_item.product.user==@current_user     # if any of them are products of mine/self
  #         total = total + order_item.subtotal         # add that subtotal to my revenue
  #       )
  #     )
  #     total
  #    )
  # end



  private

  # Method on class User - token gets added to Users database.
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

  def encrypt_password
    self.password = BCrypt::Engine.hash_secret(password, SALT)
  end

  def clear_password
    self.password = nil
  end


end

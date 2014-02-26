class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  # validates :price, format: { with: /^(\d*\.\d{1,2}|\d+)$/,
  #   message: "must be in $dd.cc format, ex. $15.45" }

  belongs_to :user

  has_many :reviews
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :product_to_category_relationships
  has_many :categories, through: :product_to_category_relationships


# Validations
  validates :name,      presence: true,
                        uniqueness: true

  validates :price,     presence: true,
                        numericality: {:greater_than => 0}


  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    elsif filter_term
      # search = includes(:categories)
      a = filter_term.flat_map do |category|
        search = includes(:categories).where('categories.category LIKE :s', s: "%#{category}%")
      end
    else
        find(:all)
    end

    before_save do
      @product.price = @product.price * 100
    end
  end

  def add_categories(categories_array)
    categories_array.delete_if(&:empty?)

    categories_array.each do |category_id|
      categories << Category.find(category_id.to_i)
    end
  end

  def update_categories(categories_array)
    categories_array.delete_if(&:empty?)

    categories_array.each do |category_id|
      categories << Category.find(category_id.to_i)
    end
  end
end

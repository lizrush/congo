class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  has_many :reviews
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :product_to_category_relationships
  has_many :categories, through: :product_to_category_relationships

  validates_presence_of :name, :description, :price, :stock, :weight, :height, :width, :length
  validates_uniqueness_of :name
  validates :price, numericality: {:greater_than => 0}


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

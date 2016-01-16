class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]

    add_to_products
  end

  def in_stock?
    @stock > 0
  end

  def decrement_stock
    decrement_stock_by(1)
  end

  def decrement_stock_by(num)
    @stock -= num
  end

  def increment_stock
    increment_stock_by(1)
  end

  def increment_stock_by(num)
    @stock += num
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
    @@products.find {|p| p.title.eql?(title)}
  end

  def self.in_stock
    @@products.find_all {|p| p.in_stock?}
  end

  private

  def add_to_products
    raise DuplicateProductError, "'#{@title}' already exists." if Product.find_by_title(@title)
    @@products << self
  end
end

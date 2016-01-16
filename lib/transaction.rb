class Transaction
  attr_reader :id, :product, :customer

  @@id = 1
  @@transactions = []

  def initialize(customer, product)
    @customer = customer
    @product = product
    @id = @@id
    @@id += 1

    if @product.in_stock?
      @product.decrement_stock
    else
      raise OutOfStockError, "'#{@product.title}' is out of stock."
    end

    add_to_transactions
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions.find {|t| t.id == id}
  end

  private

  def add_to_transactions
    @@transactions << self
  end
end

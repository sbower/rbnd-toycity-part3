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

  def self.return(customer, transaction_id)
    transaction = find(transaction_id)
    raise TransactionNotFound, "There is no transtion #{transaction_id} for #{customer.name}" if transaction.nil? || transaction.customer.name != customer.name

    @@transactions.delete_at(Transaction.all.find_index {|t| t.id == transaction.id})
    transaction.product.increment_stock
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions.find {|t| t.id == id}
  end

  def self.find_by_product(product_title)
    @@transactions.find_all {|t| t.product == product_title}
  end

  def self.find_by_zip(zip_code)
    @@transactions.find_all {|t| t.customer.zip_code == zip_code}
  end

  def self.find_by_age(age)
    @@transactions.find_all {|t| t.customer.age == age}
  end

  def self.find_by_customer(customer_name)
    @@transactions.find_all {|t| t.customer.name == customer_name}
  end

  private

  def add_to_transactions
    @@transactions << self
  end
end

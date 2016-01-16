class Customer
  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]

    add_to_customers
  end

  def purchase(product)
    Transaction.new(self, product)
  end

  def self.all
    @@customers
  end

  def self.find_by_name(name)
    @@customers.find {|c| c.name.eql?(name)}
  end

  private

  def add_to_customers
    raise DuplicateCustomerError, "'#{@name}' already exists." if Customer.find_by_name(@name)
    @@customers << self
  end
end

class Customer
  attr_reader :name, :age, :zip_code

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    @age = options[:age] || nil
    @zip_code = options[:zip_code] || nil

    add_to_customers
  end

  def purchase(product)
    Transaction.new(self, product)
  end

  def return(transaction_id)
    Transaction.return(self, transaction_id)
  end

  def self.get_all_zip_codes
    @@customers.map {|c| c.zip_code}.uniq
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

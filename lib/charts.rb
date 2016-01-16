class Charts

  def self.draw_products_per_zip
    puts AsciiCharts::Cartesian.new(
      Customer.get_all_zip_codes.map {|z| [z.nil? ? "Unkown" : z , Transaction.find_by_zip(z).count] },
      :bar => true,
      :hide_zero => true).draw
  end

end

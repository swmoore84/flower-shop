class FlowerShop
  # Defines available products with bundle sizes and prices
  PRODUCTS = {
    "R12" => { 10 => 12.99, 5 => 6.99 },
    "L09" => { 9 => 24.95, 6 => 16.95, 3 => 9.95 },
    "T58" => { 9 => 16.99, 5 => 9.95, 3 => 5.95 }
  }

  # Method used to process an order, can take a multiline string as the input
  # Example input format:
  #   10 R12
  #   15 L09
  #   13 T58
  def self.process_order(input)
    # Iterate through each line of the input
    input.each_line do |line|
      # Split the line into quantity and product code
      quantity, code = line.split
      quantity = quantity.to_i  # Convert quantity to integer

      # Calling the bundle_order_items method passing in the quantity, and the product's bundles
      bundled_items = bundle_order_items(quantity, PRODUCTS[code])

      # Calculate the total price by summing the cost of each bundle
      total_price = bundled_items.sum { |bundle, count| count * PRODUCTS[code][bundle] }

      # Output the total order summary
      puts "#{quantity} #{code} $#{'%.2f' % total_price}"

      # Output each bundle's details
      bundled_items.each do |bundled_product, count|
        puts "#{count} x #{bundled_product} $#{'%.2f' % (count * PRODUCTS[code][bundled_product])}"
      end
    end
  end


  # Method used to determine the best way to bundle a given quantity
  # Takes the quantity and available bundles for the product
  def self.bundle_order_items(quantity, bundles)
    best_bundle = nil
    min_remainder = quantity

    # Iterate through bundles, starting from the largest, continues until minimum number of bundles found
    bundles.each_with_index do |(size, _price), index|
      remaining_quantity = quantity
      temp_result = {}

      # Iterate through bundle keys starting from the current index
      bundles.keys.drop(index).each do |bundle_size|
        count = remaining_quantity / bundle_size
        if count > 0
          temp_result[bundle_size] = count
          remaining_quantity %= bundle_size
        end
      end

      # If there's no remainder, return immediately
      return temp_result if remaining_quantity == 0

      # Update the best bundle combination if it leaves a smaller remainder
      if remaining_quantity < min_remainder
        min_remainder = remaining_quantity
        best_bundle = temp_result
      end
    end

    best_bundle || {}  # Return the best found combination, or an empty hash if no exact match
  end
end

# Example input in a multiline string format
input_data = <<~INPUT
  10 R12
  15 L09
  13 T58
INPUT

# Process the order based on the input data
FlowerShop.process_order(input_data)

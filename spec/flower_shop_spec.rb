require_relative '../lib/flower_shop'
require 'rspec'

RSpec.describe FlowerShop do
  describe '.process_order' do
    it 'prints correct output for multiple products' do
      input_data = <<~INPUT
        10 R12
        15 L09
        13 T58
      INPUT

      expected_output = <<~OUTPUT
        10 R12 $12.99
        1 x 10 $12.99
        15 L09 $41.90
        1 x 9 $24.95
        1 x 6 $16.95
        13 T58 $25.85
        2 x 5 $19.90
        1 x 3 $5.95
      OUTPUT

      expect { FlowerShop.process_order(input_data) }.to output(expected_output).to_stdout
    end
  end
end

module Refund
  module Rules
    class ParkingRule < Rule
      BUILDER_NAME = "parking".freeze

      def apply(items: [])
         units = items
                   .select { |item| item.is_parking? }
                   .collect { |item| item.units }
                   .inject(0) { |sum, n| sum + n }

        [units, self.threshold].min * self.first_rate + [0, (units - self.threshold)].max * self.second_rate
      end
    end
  end
end
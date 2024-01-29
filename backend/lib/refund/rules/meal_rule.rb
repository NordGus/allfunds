module Refund
  module Rules
    class MealRule < Rule
      BUILDER_NAME = "meal".freeze

      def apply(items: [])
         units = items
                   .select { |item| item.is_meal? }
                   .inject{ |sum, item| sum + item.units }

        [units, self.threshold].min * self.first_rate + [0, (units - self.threshold)].max * self.second_rate
      end
    end
  end
end
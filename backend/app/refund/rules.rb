module Refund
  module Rules
    class Rule
      include ActiveModel::Model
      include ActiveModel::Attributes

      attr_accessor :first_rate, :threshold, :second_rate

      attribute :first_rate, default: 0
      attribute :second_rate, default: 0
      attribute :threshold, :integer, default: 0

      validates :first_rate, numericality: { greater_than: 0 }
      validates :second_rate, numericality: { greater_than: 0 }
      validates :threshold, numericality: { greater_than: 0 }

      def apply(items: [])
        raise NotImplementedError
      end
    end

    def self.new_for(rule: "", args: {})
      case rule
      when TransportationRule::BUILDER_NAME
        TransportationRule.new(args)
      when MealRule::BUILDER_NAME
        MealRule.new(args)
      when ParkingRule::BUILDER_NAME
        ParkingRule.new(args)
      else
        raise NotImplementedError
      end
    end
  end
end

require_relative 'rules/transportation_rule'
require_relative 'rules/meal_rule'
require_relative 'rules/parking_rule'
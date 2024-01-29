module Refund
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

    def self.new_from(rule: "", args: {})
      case rule
      when Rules::TransportationRule::BUILDER_NAME
        Rules::TransportationRule.new(args)
      when Rules::MealRule::BUILDER_NAME
        Rules::MealRule.new(args)
      when Rules::ParkingRule::BUILDER_NAME
        Rules::ParkingRule.new(args)
      else
        raise NotImplementedError
      end
    end

    def apply(items: [])
      raise NotImplementedError
    end
  end
end
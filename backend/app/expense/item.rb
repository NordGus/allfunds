# frozen_string_literal: true

module Expense
  class Item
    include ActiveModel::Model
    include ActiveModel::Attributes

    TRANSPORTATION_CONCEPT = "transportation".freeze
    MEAL_CONCEPT = "meal".freeze
    PARKING_CONCEPT = "parking".freeze

    CONCEPTS = [
      TRANSPORTATION_CONCEPT,
      MEAL_CONCEPT,
      PARKING_CONCEPT
    ].freeze

    attribute :concept, :string
    attribute :units, :integer, default: 0

    validates :units, numericality: { greater_than_or_equal_to: 1 }
    validates :concept, inclusion: { in: CONCEPTS }

    # some meta programing for fun.
    def method_missing(method, *args, &block)
      return method.to_s.include?(self.concept) if CONCEPTS.collect{ |concept| "is_#{concept}?" }.include?(method.to_s)

      super(method, args, &block)
    end
  end
end
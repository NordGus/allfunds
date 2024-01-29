# frozen_string_literal: true

module Expense
  class Report
    include ActiveModel::Model
    include ActiveModel::Attributes

    attr_accessor :total, :items

    attribute :items
    attribute :total, default: 0

    def self.new_with_items(items: [])
      new(items: items.collect{ |params| Item.new(params) })
    end

    def calculate_refund(rules = [])
      self.total = rules.inject(BigDecimal(0, 2)) { |sum, rule| sum + rule.apply(items: self.items) }
    end
  end
end
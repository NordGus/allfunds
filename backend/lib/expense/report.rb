# frozen_string_literal: true

module Expense
  class Report
    include ActiveModel::Model
    include ActiveModel::Attributes

    attr_accessor :total, :rules, :items

    attribute :rules
    attribute :items
    attribute :total, default: 0

    def self.new_with_rules_and_items(rules: [], items: [])
      new(
        rules: rules.collect{ |rule| Refund::Rule.new_from(rule: rule[:rule], args: rule[:args]) },
        items: items.collect{ |params| Item.new(params) }
      )
    end

    def calculate_refund
      self.total = self.rules.inject(BigDecimal(0, 2)) { |sum, rule| sum + rule.apply(items: self.items) }
    end
  end
end
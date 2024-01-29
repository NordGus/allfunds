# frozen_string_literal: true

module Expense
  class Report
    include ActiveModel::Model
    include ActiveModel::Attributes

    attr_accessor :total, :rules, :items

    attribute :rules
    attribute :items
    attribute :total, default: 0

    def self.new_with_items(rules: [], items: [])
      report = new(
        rules: rules.collect{ |rule| Refund::Rule.new_from(rule: rule[:rule], args: rule[:args]) },
        items: items.collect{ |params| Item.new(params) }
      )

      report.valid?
      report.rules.each { |rule| rule.valid? }
      report.items.each { |item| item.valid? }

      report
    end

    def calculate_total
      self.total = self.rules.inject(BigDecimal(0, 2)) { |sum, rule| sum + rule.apply(self.items) }
    end
  end
end
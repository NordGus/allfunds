RSpec.describe Refund::Rules::TransportationRule do
  describe "#apply" do
    let(:items) {
      [
        Expense::Item.new(concept: "transportation", units: 75),
        Expense::Item.new(concept: "meal", units: 1),
        Expense::Item.new(concept: "transportation", units: 15),
        Expense::Item.new(concept: "meal", units: 1),
        Expense::Item.new(concept: "meal", units: 1),
        Expense::Item.new(concept: "parking", units: 15),
        Expense::Item.new(concept: "transportation", units: 20),
        Expense::Item.new(concept: "meal", units: 1),
        Expense::Item.new(concept: "parking", units: 20),
      ]
    }

    let(:items_without_transportation) { items.select { |item| !item.is_transportation? } }

    context "when the threshold is surpassed" do
      it "must calculate the refund from transportation expenses" do
        rule = Refund::Rules::TransportationRule.new(first_rate: 0.12, threshold: 100, second_rate: 0.08)

        expect(rule.apply(items: items)).to eq(12.80)
      end
    end

    context "when the threshold is not surpassed" do
      it "must calculate the refund from transportation expenses" do
        rule = Refund::Rules::TransportationRule.new(first_rate: 0.12, threshold: 150, second_rate: 0.08)

        expect(rule.apply(items: items)).to eq(13.20)
      end
    end

    context "when no transportation items are passed" do
      it "must calculate the refund from transportation expenses" do
        rule = Refund::Rules::TransportationRule.new(first_rate: 0.12, threshold: 100, second_rate: 0.08)

        expect(rule.apply(items: items_without_transportation)).to eq(0.00)
      end
    end
  end
end
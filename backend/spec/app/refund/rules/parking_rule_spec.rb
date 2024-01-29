RSpec.describe Refund::Rules::ParkingRule do
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

    let(:items_without_parking) { items.select { |item| !item.is_parking? } }

    context "when the threshold is surpassed" do
      it "must calculate the refund from meals" do
        rule = Refund::Rules::ParkingRule.new(first_rate: 1, threshold: 20, second_rate: 0.5)

        expect(rule.apply(items: items)).to eq(27.50)
      end
    end

    context "when the threshold is not surpassed" do
      it "must calculate the refund from meals" do
        rule = Refund::Rules::ParkingRule.new(first_rate: 1, threshold: 40, second_rate: 0.5)

        expect(rule.apply(items: items)).to eq(35.00)
      end
    end

    context "when no transportation items are passed" do
      it "must calculate the refund from meals" do
        rule = Refund::Rules::ParkingRule.new(first_rate: 1, threshold: 20, second_rate: 0.5)

        expect(rule.apply(items: items_without_parking)).to eq(0.00)
      end
    end
  end
end
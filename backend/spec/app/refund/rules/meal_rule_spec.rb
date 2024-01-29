RSpec.describe Refund::Rules::MealRule do
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

    let(:items_without_meals) { items.select { |item| !item.is_meal? } }

    context "when the threshold is surpassed" do
      it "must calculate the refund from meals" do
        rule = Refund::Rules::MealRule.new(first_rate: 10, threshold: 3, second_rate: 6)

        expect(rule.apply(items: items)).to eq(36.00)
      end
    end

    context "when the threshold is not surpassed" do
      it "must calculate the refund from meals" do
        rule = Refund::Rules::MealRule.new(first_rate: 10, threshold: 5, second_rate: 6)

        expect(rule.apply(items: items)).to eq(40.00)
      end
    end

    context "when no transportation items are passed" do
      it "must calculate the refund from meals" do
        rule = Refund::Rules::MealRule.new(first_rate: 10, threshold: 3, second_rate: 6)

        expect(rule.apply(items: items_without_meals)).to eq(0.00)
      end
    end
  end
end
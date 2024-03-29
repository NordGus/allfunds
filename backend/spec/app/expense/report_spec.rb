RSpec.describe Expense::Report do
  let(:rules) {
    [
      Refund::Rules.new_for(rule: "transportation", args: { first_rate: 0.12, threshold: 100, second_rate: 0.08 }),
      Refund::Rules.new_for(rule: "meal", args: { first_rate: 10, threshold: 3, second_rate: 6 }),
      Refund::Rules.new_for(rule: "parking", args: { first_rate: 1, threshold: 20, second_rate: 0.5 })
    ]
  }

  let(:items_1) {
    [
      {concept: "transportation", units: 75},
      {concept: "meal", units: 1},
      {concept: "transportation", units: 15},
      {concept: "meal", units: 1},
      {concept: "meal", units: 1},
      {concept: "parking", units: 15},
      {concept: "transportation", units: 20},
      {concept: "meal", units: 1},
      {concept: "parking", units: 20},
    ]
  }

  let(:items_2) {
    [
      {concept: "transportation", units: 75},
      {concept: "meal", units: 1},
      {concept: "transportation", units: 45},
      {concept: "meal", units: 1},
      {concept: "transportation", units: 35},
      {concept: "meal", units: 1},
      {concept: "meal", units: 1},
      {concept: "parking", units: 35},
      {concept: "transportation", units: 20},
      {concept: "meal", units: 1},
      {concept: "parking", units: 10},
    ]
  }

  describe "self.new_with_items" do
    subject(:report) { Expense::Report.new_with_items(items: items_1) }

    it "should return an Expense::Report instance" do
      expect(report).to be_instance_of(Expense::Report)
    end

    it "should initialize items instances" do
      expect(report.items.sample).to be_a_kind_of(Expense::Item)
    end

    context "first item" do
      it "should have the expected concept" do
        expect(report.items.first.concept).to eq(items_1.first[:concept])
      end

      it "should have the expected amount units" do
        expect(report.items.first.units).to eq(items_1.first[:units])
      end
    end
  end

  describe "#calculate_refund" do
    context "report #1" do
      subject(:report) { Expense::Report.new_with_items(items: items_1) }

      it "should return the expected amount to refund" do
        expect(report.calculate_refund(rules)).to eq(76.30)
      end
    end

    context "report #2" do
      subject(:report) { Expense::Report.new_with_items(items: items_2) }

      it "should return the expected amount to refund" do
        expect(report.calculate_refund(rules)).to eq(92.50)
      end
    end
  end
end
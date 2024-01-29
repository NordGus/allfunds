RSpec.describe Expense::Report do
  let(:rules) {
    [
      { rule: "transportation", args: { first_rate: 0.12, threshold: 100, second_rate: 0.08 } },
      { rule: "meal", args: { first_rate: 10, threshold: 3, second_rate: 6 } },
      { rule: "parking", args: { first_rate: 1, threshold: 20, second_rate: 0.5 } }
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
    subject(:report) { Expense::Report.new_with_items(rules: rules, items: items_1) }

    it "should return an Expense::Report instance" do
      expect(report).to be_instance_of(Expense::Report)
    end

    context "rules" do
      it "should initialize rules instances" do
        expect(report.rules.sample).to be_a_kind_of(Refund::Rule)
      end

      context "rule arguments" do
        it "should initialize the correct rule" do
          expect(report.rules.first).to be_instance_of(Refund::Rules::TransportationRule)
        end

        it "should have the expected first_rate" do
          expect(report.rules.first.first_rate).to eq(rules.first[:args][:first_rate])
        end

        it "should have the expected second_rate" do
          expect(report.rules.first.second_rate).to eq(rules.first[:args][:second_rate])
        end

        it "should have the expected threshold" do
          expect(report.rules.first.threshold).to eq(rules.first[:args][:threshold])
        end
      end
    end

    context "items" do
      it "should initialize items instances" do
        expect(report.items.sample).to be_a_kind_of(Expense::Item)
      end

      context "item arguments" do
        it "should have the expected concept" do
          expect(report.items.first.concept).to eq(items_1.first[:concept])
        end

        it "should have the expected amount units" do
          expect(report.items.first.units).to eq(items_1.first[:units])
        end
      end
    end
  end
end
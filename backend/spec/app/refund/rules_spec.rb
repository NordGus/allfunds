RSpec.describe Refund::Rules do
  describe "self.new_for" do
    shared_examples :refund_rule do |rule_class, rule, args|
      it "must return the expected rule instance" do
        expect(Refund::Rules.new_for(rule: rule, args: args)).to be_instance_of(rule_class)
      end
    end

    context "transportation" do
      include_examples :refund_rule, [
        Refund::Rules::TransportationRule,
        "transportation",
        { first_rate: 0.12, threshold: 100, second_rate: 0.08 }
      ]
    end

    context "meal" do
      include_examples :refund_rule, [
        Refund::Rules::MealRule,
        "meal",
        { first_rate: 10, threshold: 3, second_rate: 6 }
      ]
    end

    context "parking" do
      include_examples :refund_rule, [
        Refund::Rules::ParkingRule,
        "parking",
        { first_rate: 1, threshold: 20, second_rate: 0.5 }
      ]
    end

    context "a not implemented rule" do
      it "must raise NotImplementedError" do
        expect { Refund::Rules.new_for(rule: "not_implemented", args: {}) }.to raise_error(NotImplementedError)
      end
    end
  end
end
RSpec.describe Expense::Item do
  describe "#method_missing" do
    describe "#is_{concept}?" do
      shared_examples "#is_{concept}?" do |concept, invalid_context|
        let(:valid_item) { Expense::Item.new(concept: concept, units: 1) }
        let(:invalid_item) { Expense::Item.new(concept: invalid_context, units: 1) }

        context "must respond to is_#{concept}?" do
          it "is truthy when the item has the same concept" do
            expect(valid_item.send("is_#{concept}?")).to be_truthy
          end

          it "is falsey when the item has the same concept" do
            expect(invalid_item.send("is_#{concept}?")).to be_falsey
          end
        end
      end

      context "transportation concept" do
        include_examples "#is_{concept}?", Expense::Item::TRANSPORTATION_CONCEPT, Expense::Item::MEAL_CONCEPT
      end

      context "meal concept" do
        include_examples "#is_{concept}?", Expense::Item::MEAL_CONCEPT, Expense::Item::TRANSPORTATION_CONCEPT
      end

      context "parking concept" do
        include_examples "#is_{concept}?", Expense::Item::PARKING_CONCEPT, Expense::Item::MEAL_CONCEPT
      end
    end
  end
end
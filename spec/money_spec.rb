require "money_ruby/money"

RSpec.describe Money do
  context "initialize" do
    it "accepts an amount and a currency to create the money value object" do
      expect {
        Money.new(50, "EUR")
      }.not_to raise_error
    end
  end

  context "#currency" do
    it "exposes the currency" do
      money = Money.new(50, "EUR")

      expect(money.currency).to eq "EUR"
    end
  end

  context "#amount" do
    it "exposes the amount" do
      money = Money.new(50, "EUR")

      expect(money.amount).to eq 50
    end
  end
end

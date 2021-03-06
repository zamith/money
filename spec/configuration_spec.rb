require "money_ruby/money"

RSpec.describe Money do
  after(:each) do
    Money.clear_conversion_rates!
  end

  context ".clear_conversion_rates!" do
    it "clears any conversion rate in memory" do
      Money.conversion_rates("EUR", { "USD" => 1.11 })

      Money.clear_conversion_rates!

      expect {
        Money.conversion_rate(from: "EUR", to: "USD")
      }.to raise_error NoConversionRateError
    end
  end

  context ".conversion_rate" do
    it "raise an error if no conversion rate found" do
      expect {
        Money.conversion_rate(from: "EUR", to: "USD")
      }.to raise_error NoConversionRateError
    end
  end

  context ".conversion_rates" do
    it "sets the conversion rate for a given currency" do
      Money.conversion_rates("EUR", { "USD" => 1.11 })

      expect(Money.conversion_rate(from: "EUR", to: "USD")).to eq 1.11
    end
  end
end

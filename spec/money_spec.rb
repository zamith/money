require "money_ruby/money"

RSpec.describe Money do
  context "initialize" do
    it "accepts an amount and a currency to create the money value object" do
      expect {
        Money.new(50, "EUR")
      }.not_to raise_error
    end

    it "accepts the amount in cents" do
      money = Money.new(1000, "EUR", unit: :cent)

      expect(money).to eq Money.new(10, "EUR")
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
      money = Money.new(50.50, "EUR")

      expect(money.amount).to eq 50.50
    end
  end

  context "#inspect" do
    it "prints the money information nicely" do
      money = Money.new(50, "EUR")

      expect(money.inspect).to match(/50.00 EUR/)
    end
  end

  context "#convert_to" do
    it "returns a new object using the specified currency conversions" do
      Money.conversion_rates("EUR", { "USD" => 1.11 })
      money = Money.new(50, "EUR")

      expect(money.convert_to("USD")).to eq Money.new(55.50, "USD")

      Money.clear_conversion_rates!
    end
  end

  context "Comparable" do
    it "is equal to the same amount in the same currency" do
      expect(Money.new(50, "EUR")).to eq Money.new(50, "EUR")
    end

    it "is bigger than a smaller amount in the same currency" do
      expect(Money.new(50, "EUR")).to be > Money.new(10, "EUR")
    end

    it "is equal to the same amount in a different currency" do
      Money.conversion_rates("EUR", { "USD" => 1.11 })
      money_in_eur = Money.new(50, "EUR")
      money_in_usd = money_in_eur.convert_to("USD")

      expect(money_in_usd).to eq money_in_eur

      Money.clear_conversion_rates!
    end

    it "is bigger than a smaller amount in a different currency" do
      Money.conversion_rates("USD", { "EUR" => 0.89 })
      money_in_eur = Money.new(10, "USD").convert_to("EUR")

      expect(Money.new(50, "EUR")).to be > money_in_eur

      Money.clear_conversion_rates!
    end
  end

  context "#+" do
    it "sums values of the same currency" do
      expect(Money.new(10, "USD") + Money.new(20, "USD")).to eq Money.new(30, "USD")
    end

    it "sums values with different currencies" do
      Money.conversion_rates("EUR", { "USD" => 1.11 })

      expect(Money.new(10, "USD") + Money.new(20, "EUR")).to eq Money.new(32.20, "USD")

      Money.clear_conversion_rates!
    end
  end

  context "#-" do
    it "subtracts values of the same currency" do
      expect(Money.new(20, "USD") - Money.new(10, "USD")).to eq Money.new(10, "USD")
    end

    it "sums values with different currencies" do
      Money.conversion_rates("EUR", { "USD" => 1.11 })

      expect(Money.new(30, "USD") - Money.new(20, "EUR")).to eq Money.new(7.80, "USD")

      Money.clear_conversion_rates!
    end
  end

  context "#*" do
    it "multiplies values" do
      expect(Money.new(20, "USD") * 3).to eq Money.new(60, "USD")
    end

    it "multiplies values reversed" do
      expect(3 * Money.new(20, "USD")).to eq Money.new(60, "USD")
    end
  end

  context "#/" do
    it "divides values" do
      expect(Money.new(20, "USD") / 2).to eq Money.new(10, "USD")
    end

    it "divides values with decimal places" do
      expect(Money.new(20.50, "USD") / 2).to eq Money.new(10.25, "USD")
    end
  end
end

# Money Ruby

Handles money in Ruby. Everything from arithmetic with different currencies, to
converting currencies.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'money_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install money_ruby

## Usage

### Configure the currency rates with respect to a base currency (here EUR):

```ruby
Money.conversion_rates('EUR', {
  'USD'     => 1.11,
  'Bitcoin' => 0.0047
})
```

### Instantiate money objects:

```ruby
fifty_eur = Money.new(50, 'EUR')
```

### Get amount and currency:

```ruby
fifty_eur.amount   # => 50
fifty_eur.currency # => "EUR"
fifty_eur.inspect  # => "50.00 EUR"
```

### Convert to a different currency (should return a Money instance, not a String):

```ruby
fifty_eur.convert_to('USD') # => 55.50 USD
```

### Perform operations in different currencies:

```ruby
twenty_dollars = Money.new(20, 'USD')
```

### Arithmetics:

```ruby
fifty_eur + twenty_dollars # => 68.02 EUR
fifty_eur - twenty_dollars # => 31.98 EUR
fifty_eur / 2              # => 25 EUR
twenty_dollars * 3         # => 60 USD
```

### Comparisons (also in different currencies):

```ruby
twenty_dollars == Money.new(20, 'USD') # => true
twenty_dollars == Money.new(30, 'USD') # => false

fifty_eur_in_usd = fifty_eur.convert_to('USD')
fifty_eur_in_usd == fifty_eur          # => true

twenty_dollars > Money.new(5, 'USD')   # => true
twenty_dollars < fifty_eur             # => true
```

## Contributing

1. Fork it ( https://github.com/zamith/money/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

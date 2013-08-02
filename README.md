# Sterilizer

A simple module that extends a String, giving it a `sterilize!` method to ensure the string is always valid UTF-8

## Installation

Add this line to your application's Gemfile:

    gem 'sterilizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sterilizer

## Usage
Handy when you want to ensure incoming strings will contain invalid characters
```ruby

dodgy_params = {
  :ok => "Hello",
  :dodgy => "hi \255",
  :accented => "\xE9",
}
guarantee_strings!(dodgy_params)
# =>
    {
        :ok=>"Hello",
        :dodgy=>"hi ­"
        :accented=>"é"
    }

private

def guarantee_strings!(unclean_params)
  unclean_params.each do |_,v|
    v.sterilize!
  end
end
```

It uses the https://github.com/oleander/rchardet gem to guess the character encoding if the string isn't valid when forced to UTF-8

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

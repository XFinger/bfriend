# Bfriend

A simple generator for creating a Self-Referential Association for a friendship model. This is heavily based on [Ryan Bates rails cast #163](http://railscasts.com/episodes/163-self-referential-association).  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bfriend'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bfriend

## Usage

Run the bfriend generator `rails g bfriend`. This will generate a friendship model, a migration, add a route to routes, add associations to your user model and generate a friendship controller suitable for use in an API.
If you use the gem for a ruby on rails project, run `rails g bfriend -t --ror` .
At this time no view templates are created and I will update this readme when and if I add them.

 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/XFinger/bfriend.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
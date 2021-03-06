

I often need friendship modeling for projects so I created a generator to get up and running quickly. 
This is a simple generator for creating a Self-Referential Association for a friendship model. Heavily based on [Ryan Bates rails cast #163](http://railscasts.com/episodes/163-self-referential-association) with some help from [this guy on github](https://github.com/tobyond?tab=repositories). It isn't particularly sophisticated or polished and doesn't include any tests so use at your own risk. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bfriend'
```

And then execute:

    bundle

Or install it yourself as:

    gem install bfriend

## Usage

Run the bfriend generator `rails g bfriend`. This will generate a friendship model, a migration, add routes & associations to your user model and generate a friendship controller suitable for use in an API.

If you are using the gem for a ruby on rails project, run `rails g bfriend --ror` .

Edit the migration to give the status a default of false 

    t.boolean :accepted, default: false" 

Run your migration 

Now you can:

    request friendship:          Friendship.create( user_id: id, friend_id: id )
    accept friendship:           Friendship.update( status: true )
    decline friendship:          Friendship.delete
    end friendship:              Friendship.delete
    all friends:                 user.friends
    all requests:                user.pending
    friend_requests:             user.pending_friends
    requested_friends:           user.requested_friends
    friendship by user:          user.current_friends
    friendship by friend:        user.bfriended_friends
    

At this time no view templates are created and I will update this readme when and if I add them.
 
### Upgrading to >=  0.8.0
The class methods have been moved to the bfriend module of the gem so you will need to remove them from your user model and add `include Bfriend`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/XFinger/bfriend.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
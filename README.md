

I often need friendship modeling for projects so I created a generator to get up and running quickly. 
This is a simple generator for creating a Self-Referential Association for a friendship model. This is heavily based on [Ryan Bates rails cast #163](http://railscasts.com/episodes/163-self-referential-association) with some help from [this guy on github](https://github.com/tobyond?tab=repositories). It isn't particularly sophisticated and dosn't include any tests so use at your own risk. 

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

If you are using  the gem for a ruby on rails project, run `rails g bfriend -t --ror` .

Edit the migration to give the status a default of false 

    t.boolean :accepted, default: false" 

Run your migration 

Now you can:

    request friendship:          <%= link_to "Add Friend", friendships_path(:friend_id => user), :method => :post %>
    accept/decline friendship:   <%= link_to "Accept",  friendship_path(id: request.id), method: "put" %>
                                 <%= link_to "Decline", friendship_path(id: request.id), method: :delete %>
    end friendship:              <%= link_to "End", friendship_path(id: request.id), method: :delete %>
    view friends:                <% current_user.friends.each do |friend| %>
                                     <%= friend.username %>
                                 <% end %>


At this time no view templates are created and I will update this readme when and if I add them.
 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/XFinger/bfriend.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
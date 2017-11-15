# Immoscout

This gem provides an API wrapper for the [Immobilienscout24 REST API](https://api.immobilienscout24.de/our-apis/import-export.html).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'immoscout'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install immoscout

## Usage

### Configuration

```ruby
Immoscout.configure do |config|
  config.consumer_key = "key"
  config.consumer_secret = "secret"
  config.oauth_token = "token"
  config.oauth_token_secret = "token_secret"
  config.use_sandbox = true # default: false
end
```

### Models

#### Real Estates

Currently supported: `ApartmentBuy`, `HouseBuy`

##### Overview supported actions
* .find(ID)
* .all
* .first
* .last
* .new(hash)
* .from_raw(remote_hash_or_json)
* .create(hash)
* #save
* #destroy
* #publish
* #unpublish
* #place(placement_type)
* #unplace(placement_type)

##### Initialize
```ruby
# initialize with hash
house = Immoscout::Models::HouseBuy.new(title: "test", address: {street: "thestreet"})
# => #<Immoscout::Models::HouseBuy:0x0055c9fbbc6ea0 @address=#<Immoscout::Models::Parts::Address:0x0055c9fbbc6888 @street="thestreet">, @title="test">

# initialize with attribute writers
house = Immoscout::Models::HouseBuy.new
# => #<Immoscout::Models::HouseBuy:0x0055d31f734838>
house.title = "another title"
# => "another title"

# access nested attributes
house.build_address
# => #<Immoscout::Models::Parts::Address:0x0055c9fbc77d18>
house.address.street = "another street"

# lookup all allowed first-level attributes
house.attributes
# => [:address, :api_search_data, :building_energy_rating_type, ...]
house.address.attributes
# => [:city, :house_number, :postcode, :street, ...]
```

##### Find
```ruby
apartment = Immoscout::Models::ApartmentBuy.find('ID')
# => #<Immoscout::Models::ApartmentBuy:0x0055c9fbfa0648>
apartment.address.street
# => 'Orig street name'
```
##### Create & Update & Destroy
```ruby
apartment = Immoscout::Models::ApartmentBuy.find('ID')
apartment.address.street = "Changed street"
apartment.save
# => #<Immoscout::Models::ApartmentBuy:0x0055c9fbfa0648>

house = Immoscout::Models::HouseBuy.find('9473634')
house.destroy
# => #<Immoscout::Models::HouseBuy:0x0055d31f734838>
```

##### Publish & Unpublish
```ruby
apartment = Immoscout::Models::ApartmentBuy.find('ID')
# => #<Immoscout::Models::ApartmentBuy:0x0055c9fbfa0648>
apartment.publish
# => #<Immoscout::Models::Publish:0x0085a2fbfa0688>
apartment.unpublish
# => #<Immoscout::Models::Publish:0x00831b2fbfc1234>
```

##### Ontop-Placement
```ruby
# allowed placement types: showcaseplacement, premiumplacement, topplacement
apartment = Immoscout::Models::ApartmentBuy.find('ID')
# add premiumplacement
apartment.place(:premiumplacement)
# => #<Immoscout::Models::ApartmentBuy:0x0055c9fbfa0648>
# remove premiumplacement
apartment.unplace(:premiumplacement)
# => #<Immoscout::Models::ApartmentBuy:0x0055c9fbfa0648>
```

#### Contact

##### Overview supported actions
* .find(ID)
* .all
* .first
* .last
* .new(hash)
* .from_raw(remote_hash_or_json)
* .create(hash)
* #save
* #destroy

```ruby
contact = Immoscout::Models::Contact.new firstname: "John", lastname: "Doe"
# => #<Immoscout::Models::Contact:0x0055c9fb889878 @firstname="John", @lastname="Doe">
contact.email = "john.doe@example.com"
contact.salutation = "MALE"
contact.save
# => #<Immoscout::Models::Contact:0x0055c9fb889878 @email="john.doe@example.com", @firstname="John", @lastname="Doe", @salutation="MALE">
```

#### Publish

If you don't like the `#publish` and `#unpublish` methods defined for realestate models, you can create the `Publish` instance yourself.

##### Overview supported actions
* .new(hash)
* .from_raw(remote_hash_or_json)
* #save
* #destroy

```ruby
# NOTE: publish_channel#id = 10000 => publish on immobilienscout24
publish = Immoscout::Models::Publish.new real_estate: { id: "ID" }, publish_channel: {id: 10_000}

publish.save # published!
# => #<Immoscout::Models::Publish:0x0055c9faea1fb8>
publish.destroy # unpublished!
# => #<Immoscout::Models::Publish:0x0055c9faea1fb8>
```

#### Attachment (Picture & Document)

##### Overview supported actions
* .new(hash)
* .from_raw(remote_hash_or_json)
* #save
* #destroy

```ruby
picture = Immoscout::Models::Picture.new title: "Badezimmer", title_picture: true, floor_plan: false
picture.file = File.open("the/path/to/the/file.jpg") #
picture.attachable = Immoscout::Models::HouseBuy.last # you can also be just the ID

picture.save # attachment upload!
# => #<Immoscout::Models::Picture:0x0055c9faea1fb8>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hausgold/immoscout. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Immoscout project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hausgold/immoscout/blob/master/CODE_OF_CONDUCT.md).

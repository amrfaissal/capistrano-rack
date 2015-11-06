# capistrano-rack [![Build Status](https://travis-ci.org/amrfaissal/capistrano-rack.svg?branch=master)](https://travis-ci.org/amrfaissal/capistrano-rack)

Capistrano recipe to be served with Rackspace

## Installation

Add this line to your `Gemfile`:

```ruby
gem 'capistrano-rack'
```

and in your `Capfile`:

```ruby
require 'capistrano/rack'
```

And then execute:

	$ bundle

Make sure to have a `~/.rack/config` in your `$HOME` directory with these properties:

```text
region   = rackspace_region (e.g LON)
username = your_username
api-key  = your_api_key
```

If you are already a [**Rackspace CLI**](https://developer.rackspace.com/docs/rack-cli/) user, you can skip the step above.

## Usage

You can use `capistrano-rack` recipe in your deployment script like this:

```ruby
rackspace_servers(:roles, '^regex')
```

where `regex` is a regular expression to filter throught the names of your servers.

If you want to use a different configuration file for Rackspace, `rackspace_servers()` have an additional parameter:

```ruby
rackspace_servers(:roles, '^regex', '/path/to/my/config/file')
```

## Contributing

Bug reports and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

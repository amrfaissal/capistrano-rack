## capistrano-rack

![](https://raw.githubusercontent.com/amrfaissal/capistrano-rack/gh-pages/images/CapistranoLogo.png)

Capistrano recipe to be served with Rackspace.

[![Build Status](https://travis-ci.org/amrfaissal/capistrano-rack.svg?branch=master)](https://travis-ci.org/amrfaissal/capistrano-rack) [![Dependency Status](https://gemnasium.com/amrfaissal/capistrano-rack.svg)](https://gemnasium.com/amrfaissal/capistrano-rack) [![Gem Version](https://badge.fury.io/rb/capistrano-rack.svg)](https://badge.fury.io/rb/capistrano-rack) [![ghit.me](https://ghit.me/badge.svg?repo=amrfaissal/capistrano-rack)](https://ghit.me/repo/amrfaissal/capistrano-rack) ![](http://ruby-gem-downloads-badge.herokuapp.com/capistrano-rack?type=total)

---

`capistrano-rack` simplifies your deployment to Rackspace Cloud services by connecting you to the appropriate service matching your criteria.

## Installation

Add this line to your `Gemfile`:

```ruby
    gem 'capistrano-rack'
```

and in your `Capfile`:

```ruby
    require 'capistrano/rack'
```

Then execute:

```shell
    $ bundle && bundle exec rake
```

**NOTE** Make sure you have a `~/.rack/config` file in your `$HOME` directory with these properties:

```text
    region   = rackspace_region (e.g LON)
    username = your_username
    api-key  = your_api_key
```

If you are already a [**Rackspace CLI**](https://developer.rackspace.com/docs/rack-cli/) user, you can skip the note above.

## Usage

`capistrano-rack` recipe supports two Rackspace Cloud services with configurable options:

```ruby
    set :rack_config, "#{ENV['HOME']}/.rack/config" # default
    set :rack_connection_options, {}                # default
    set :rack_addr_type, :private                   # default
```

Where,

* `rack_config`: Rackspace configuration file.
* `rack_connection_options`: Optional connection parameters.
* `rack_addr_type`: type of IP addresses (`:public` or `:private`).

### Next Generation Cloud Servers&trade;

To deploy to your Next Gen Cloud servers:

```ruby
    rack_servers %w{app web}, '^myservers-'
```

`rack_servers()` function supports the following ordered parameters:

* `roles`: your [Capistrano Roles](http://capistranorb.com/).
* `regex_str`: a regular expression to filter throught your Next Gen Cloud servers.

### Auto Scale

To deploy to your Scaling Group:

```ruby
    rack_autoscale %w{app web}, 'mygroup'
```

`rack_autoscale()` function supports the following ordered parameters:

* `roles`: your [Capistrano Roles](http://capistranorb.com/).
* `group_name`: Name of your Scaling Group.

### Optional Connection Parameters

<table>
    <tr><th>Key</th><th>Description</th></tr>
    <tr>
        <td>connect_timeout</td>
        <td>Connection timeout (default: 60 seconds)</td>
    </tr>
    <tr>
        <td>read_timeout</td>
        <td>Read timeout for connection (default: 60 seconds)</td>
    </tr>
    <tr>
        <td>write_timeout</td>
        <td>Write timeout for connection (default: 60 seconds)</td>
    </tr>
    <tr>
        <td>proxy</td>
        <td>Proxy for HTTP and HTTPS connections</td>
    </tr>
    <tr>
        <td>ssl_ca_path</td>
        <td>Path to SSL certificate authorities</td>
    </tr>
    <tr>
        <td>ssl_ca_file</td>
        <td>SSL certificate authority file</td>
    </tr>
    <tr>
        <td>ssl_verify_peer</td>
        <td>SSL verify peer (default: true)</td>
    </tr>   
</table>

## Contributing

Bug reports, Pull requests and Stars are always welcome. For bugs and feature requests, [please create an issue](https://github.com/amrfaissal/capistrano-rack/issues/new).

## License

This gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

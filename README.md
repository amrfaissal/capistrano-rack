# capistrano-rack [![Build Status](https://travis-ci.org/amrfaissal/capistrano-rack.svg?branch=master)](https://travis-ci.org/amrfaissal/capistrano-rack) [![Gem Version](https://badge.fury.io/rb/capistrano-rack.svg)](https://badge.fury.io/rb/capistrano-rack)

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

    $ bundle && bundle exec rake

Make sure to have a `~/.rack/config` in your `$HOME` directory with these properties:

```text
region   = rackspace_region (e.g LON)
username = your_username
api-key  = your_api_key
```

If you are already a [**Rackspace CLI**](https://developer.rackspace.com/docs/rack-cli/) user, you can skip the step above.

## Usage

`capistrano-rack` recipe supports two Rackspace Cloud services:

### Next Generation Cloud Servers&trade;

To deploy to your Next Gen Cloud servers:

```ruby
rackspace_servers %w{app web}, '^myservers-'
```

`rackspace_servers()` function supports the following ordered parameters:

* `roles`: your [Capistrano Roles](http://capistranorb.com/).
* `regex_str`: a regular expression to filter throught your Next Gen Cloud servers.
* `addr_type`: type of IP addresses (`:public` or `:private`).
* `config_file`: Rackspace configuration file.
* `connection_options`: Optional connection parameters.

### Auto Scale

To deploy to your Scaling Group:

```ruby
rackspace_autoscale %w{app web}, 'mygroup'
```

`rackspace_autoscale()` function supports the following ordered parameters:

* `roles`: your [Capistrano Roles](http://capistranorb.com/).
* `group_name`: Name of your Scaling Group.
* `addr_type`: type of IP addresses (`:public` or `:private`).
* `config_file`: Rackspace configuration file.
* `connection_options`: Optional connection parameters.

### Optional Connection Parameters

<table>
    <tr><th>Key</th><th>Description</th></tr>
    <tr>
        <td>:connect_timeout</td>
        <td>Connection timeout (default: 60 seconds)</td>
    </tr>
    <tr>
        <td>:read_timeout</td>      
        <td>Read timeout for connection (default: 60 seconds)</td>  </tr>
    <tr>
        <td>:write_timeout</td>
        <td>Write timeout for connection (default: 60 seconds)</td>
    </tr>
    <tr>
        <td>:proxy</td>
        <td>Proxy for HTTP and HTTPS connections</td>
    </tr>
    <tr>
        <td>:ssl_ca_path</td>
        <td>Path to SSL certificate authorities</td>
    </tr>
    <tr>
        <td>:ssl_ca_file</td>
        <td>SSL certificate authority file</td>
    </tr>
    <tr>
        <td>:ssl_verify_peer</td>
        <td>SSL verify peer (default: true)</td>
    </tr>   
</table>

## Contributing

Bug reports and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org/) code of conduct.

## License

This gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

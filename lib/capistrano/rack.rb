# coding: utf-8
require 'fog'
require 'capistrano'
require 'capistrano/rack/version'

#
# Properties Reader
#
class PropertiesReader
  def initialize(file)
    @file = file
    @properties = {}
    IO.foreach(file) do |line|
      @properties[$1.strip] = $2 if line =~ /([^=]*)=(.*)\/\/(.*)/ || line =~ /([^=]*)=(.*)/
    end
  end

  def to_s
    output = "File Name #{@file} \n"
    @properties.each {|key,value| output += "#{key}= #{value} \n"}
    output
  end

  def get(key)
    @properties[key].strip
  end
  
end

module Capistrano
  module Rack
    @@props_reader = PropertiesReader.new("#{ENV['HOME']}/.rack/config")

    #
    # Retrieves a list of Rackspace instances containing a tag list
    # which matches a supplied hash. Matching instances are applied
    # to the Cap server list.
    #
    # Usage: servers {'app' => 'zumba', 'stack' => 'web'}
    #
    def rackspace_servers(role=nil, regex_string='')
      rackspace = Fog::Compute.new(
        {
          :provider => 'Rackspace',
          :rackspace_api_key => @@props_reader.get("api-key"),
          :rackspace_username => @@props_reader.get("username"),
          :rackspace_region => @@props_reader.get("region"),
          :version => :v2,
          :connection_options => {}
        })
      response = rackspace.list_servers
      response.body['servers'].select do |rackspace_server|
        if !rackspace_server["name"].match(/#{regex_string}/).nil?
          # Iterate over the list of private IP addresses
          rackspace_server['addresses']['private'].select do |private_addr|
            server (private_addr['addr']), %w{role || :app}
          end
        end
      end
    end
    
  end
end


self.extend Capistrano::Rack

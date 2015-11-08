# coding: utf-8
require 'fog'
require 'capistrano'
require 'capistrano/rack/version'

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

class RackspaceOptions
  def self.get(config_file=nil)
    props_reader = PropertiesReader.new(config_file || "#{ENV['HOME']}/.rack/config")
    return {
      :rackspace_api_key => props_reader.get("api-key"),
      :rackspace_username => props_reader.get("username"),
      :rackspace_region => props_reader.get("region")
    }
  end
end

module Capistrano
  module Rack
    def rackspace_servers(roles=[], regex_str='', addr_type=:private, config_file=nil, connection_options={})
      @compute_service = Fog::Compute.new(RackspaceOptions.get(config_file)
                                          .merge({
                                                   :provider => 'Rackspace',
                                                   :version => :v2,
                                                   :connection_options => connection_options
                                                 }))
      # List all servers and filter them based on the passed 'regex_str' parameter
      @compute_service.list_servers.body['servers']
        .select { |server| !server['name'].match(/#{regex_str}/).nil? }
        .flat_map { |s| s["addresses"][addr_type.to_s] }
        .select { |iface| iface['version'] == 4 }
        .map { |iface| iface['addr'] }
        .each { |server_addr| server (server_addr), roles || %w{:app} }
    end

    def rackspace_autoscale(roles=[], group_name='', addr_type=:private, config_file=nil, connection_options={})
      rackspace_options = RackspaceOptions.get(config_file)
      
      if !connection_options.empty? then
        rackspace_options.merge!({:connection_options => connection_options})
      end
      
      @compute_service = Fog::Compute.new(rackspace_options.merge({
                                                                   :provider => 'Rackspace',
                                                                   :version => :v2
                                                                 }))
      @autoscale_service = Fog::Rackspace::AutoScale.new(rackspace_options)

      # Get the servers Ids inside the specified group name
      @autoscale_service.groups.find { |g| g.group_config.name == group_name }.state['active']
        .map { |server| server['id'] }
        .map { |id| @compute_service.servers.get id }
        .flat_map { |h| h.addresses[addr_type.to_s] }
        .select { |iface| iface['version'] == 4 }
        .map { |iface| iface['addr'] }
        .each { |server_addr| server (server_addr), roles || %w{:app} }
    end
    
  end
end


self.extend Capistrano::Rack

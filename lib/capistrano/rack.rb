# coding: utf-8
require 'fog'
require 'capistrano/all'
require 'capistrano/rack/config'
require 'capistrano/rack/version'
require 'capistrano/rack/deprecated'

module Capistrano
  module Rack
    extend Deprecated
    include Capistrano::DSL::Env

    def rack_servers(roles=nil, regex_str='')
      connection_options ||= fetch(:rack_connection_options) || {}
      addr_type ||= fetch(:rack_addr_type) || :private

      @compute_service = Fog::Compute.new(RackspaceConfig.load()
                                           .merge({
                                                    :provider => 'Rackspace',
                                                    :version => :v2,
                                                    :connection_options => connection_options
                                                  }))

      # List all servers and filter them based on the passed 'regex_str' parameter
      @compute_service.list_servers.body['servers']
        .select { |server| !server['name'].match(/#{regex_str}/).nil? }
        .flat_map { |s| s['addresses'][addr_type.to_s] }
        .select { |iface| iface['version'] == 4 }
        .map { |iface| iface['addr'] }
        .each { |server_addr| server server_addr, { :roles => (roles || %w{app}) } }
    end

    def rackspace_servers(roles=nil, regex_str='', addr_type=:private, config_file=nil, connection_options={})
      # DEPRECATED: Please use #rack_servers instead
    end

    def rack_autoscale(roles=nil, group_name='')
      connection_options ||= fetch(:rack_connection_options) || {}
      addr_type ||= fetch(:rack_addr_type) || :private

      rackspace_config = RackspaceConfig.load()
      if !connection_options.empty? then
        rackspace_config.merge!({:connection_options => connection_options})
      end

      @compute_service = Fog::Compute.new(rackspace_config.merge({
                                                                   :provider => 'Rackspace',
                                                                   :version => :v2,
                                                                 }))
      @autoscale_service = Fog::Rackspace::AutoScale.new(rackspace_config)

      # Get the servers Ids inside the specified group name
      @autoscale_service.groups.find { |g| g.group_config.name == group_name }.state['active']
        .map { |server| server['id'] }
        .map { |id| @compute_service.servers.get id }
        .flat_map { |h| h.addresses[addr_type.to_s] }
        .select { |iface| iface['version'] == 4 }
        .map { |iface| iface['addr'] }
        .each { |server_addr| server server_addr, { :roles => (roles || %w{app}) } }
    end

    def rackspace_autoscale(roles=nil, group_name='', addr_type=:private, config_file=nil, connection_options={})
      # DEPRECATED: Please use #rack_autoscale instead
    end

    deprecated_alias :rackspace_servers, :rack_servers
    deprecated_alias :rackspace_autoscale, :rack_autoscale
  end
end

self.extend Capistrano::Rack

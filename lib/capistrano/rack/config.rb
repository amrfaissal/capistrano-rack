require 'capistrano/rack/props_reader'
require 'capistrano/rack/errors'
require 'capistrano/rack/colorize'

class RackspaceConfig
  def self.load()
    config_path = fetch(:rack_config) || "#{ENV['HOME']}/.rack/config"

    if !File.exist?(config_path)
      raise FileNotFoundError, "Rackspace configuration file not found".bold.red
    end

    props_reader = PropertiesReader.new(config_path)
    return {
      :rackspace_api_key => props_reader.get("api-key"),
      :rackspace_username => props_reader.get("username"),
      :rackspace_region => props_reader.get("region")
    }
  end
end

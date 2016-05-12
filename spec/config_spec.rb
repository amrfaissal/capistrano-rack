require 'capistrano/rack/config'

describe RackspaceConfig do

  describe '.load' do
    before {
      RackspaceConfig.instance_variable_set(:@config_path, "#{Dir.getwd}/spec/config")
    }

    it "returns Rackspace configuration hash" do
      expect( RackspaceConfig.load() ).to eql({
                                                :rackspace_api_key => 'your_api_key',
                                                :rackspace_username => 'your_username',
                                                :rackspace_region => 'LON'
                                              })
    end
  end

end

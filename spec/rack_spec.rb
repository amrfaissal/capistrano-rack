require 'spec_helper'

describe Capistrano::Rack do
  let(:mock_rackspace) {
    Class.new do
      include Capistrano::Rack
    end
  }
  subject { mock_rackspace.new }

  describe '.rack_servers' do
    let(:output) {
      Fog.mock!
      subject.rack_servers( %w{web}, '^myserver-' )
    }

    it 'should return an empty list of Rackspace servers' do
      expect(output).to eq []
    end
  end

  describe '.rack_autoscale' do
    let(:output) {
      Fog.mock!
      begin
        subject.rack_autoscale( %w{web}, 'mygroup' )
      rescue
        []
      end
    }

    it 'should return an empty list of Rackspace Autoscale servers in \'mygroup\'' do
      expect(output).to eq []
    end
  end
end

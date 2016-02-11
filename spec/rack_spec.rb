require 'spec_helper'

describe PropertiesReader do
  subject { PropertiesReader.new(Dir.getwd + '/spec/config') }

  describe '#to_s' do
    let(:output) { subject.to_s }

    it 'returns a string representation of your configuration file' do
      expect(output).to eq output
    end
  end

  describe '#get' do
    let(:input) { 'region' }
    let(:output) { subject.get(input) }

    it 'returns Rackspace region value in your configuration file' do
      expect(output).to eq output
    end
  end
end

describe Capistrano::Rack do
  let(:mock_rackspace) {
    Class.new do
      include Capistrano::Rack
    end
  }
  subject { mock_rackspace.new }

  describe '#rack_servers' do
    let(:output) {
      begin
        subject.rack_servers( %w{web}, '^myserver-' )
      rescue
        []
      end
    }

    it 'should return an empty list of Rackspace servers' do
      expect(output).to eq []
    end
  end

  describe '#rack_autoscale' do
    let(:output) {
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

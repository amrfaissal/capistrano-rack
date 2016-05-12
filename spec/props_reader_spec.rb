require 'capistrano/rack/props_reader'


describe PropertiesReader do

  subject { PropertiesReader.new(Dir.getwd + '/spec/config') }

  describe '#to_s' do
    let(:result) { subject.to_s }

    it 'returns a string representation of your configuration file' do
      expect(result).to eql("File Name /home/faissal/Projects/capistrano-rack/spec/config \nregion=  LON \nusername=  your_username \napi-key=  your_api_key \n")
    end
  end

  describe '#get' do
    context "given key 'region'" do
      it 'returns region value in the configuration file' do
        expect( subject.get("region") ).to eql("LON")
      end
    end

    context "given key 'username'" do
      it 'returns username value in the configuration file' do
        expect( subject.get("username") ).to eql("your_username")
      end
    end

    context "given key 'api-key'" do
      it 'returns api-key value in the configuration file' do
        expect( subject.get("api-key") ).to eql("your_api_key")
      end
    end
  end

end

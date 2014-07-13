require 'spec_helper'
require 'network'

describe 'Network::IPaddress' do

  hash = { ip: '10.10.10.10', netmask: '255.255.255.0', mtu: '1500',
           aliased: true, macaddress: 'ff:ff:ff:ff:ff:ff:ff:ff' }
  let(:resolver) { double("Network::Resolver::Linux::Ip") }
  subject { Network::IPaddress.new(hash[:ip], hash[:netmask], resolver) }

  hash.each do |k,v|
    it "should return #{k}" do
      subject.send("#{k}=",v)
      expect(subject.send(k)).to eq(v)
    end
  end

end

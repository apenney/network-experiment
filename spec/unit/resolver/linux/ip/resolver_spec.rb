require 'spec_helper'
require 'network'

describe 'Network::Resolver' do

  let(:resolver) { Network::Resolver::Linux::Ip.new('eth0') }

  before :each do
    resolver.stub(:output) { File.read('spec/fixtures/linux_ip_eth0_multiple') }
  end

  describe '#ips' do
    it 'should return appropriate objects' do
      expect(resolver.ips.map { |obj| obj.name })
        .to eq(["198.245.51.174", "10.50.50.50", "2607:5300:60:6ae::1", "fe80::4e72:b9ff:fe24:7d28"])
    end
  end

  describe '#netmask' do
    it 'should return a netmask' do
      expect(resolver.netmask('198.245.51.174')).to eq('255.255.255.0')
    end
  end

  describe '#mtu' do
    it 'should return a mtu' do
      expect(resolver.mtu).to eq('1500')
    end
  end

  describe '#alias?' do
    it 'should return false' do
      expect(resolver.alias?('198.245.51.174')).to be_false
    end
  end

end

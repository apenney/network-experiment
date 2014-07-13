require 'spec_helper'
require 'network'

describe 'Network::Resolver' do

  let(:resolver) { Network::Resolver::Linux::Ifconfig.new('eth0') }

  before :each do
    allow(resolver).to receive(:output) { File.read('spec/fixtures/linux_ifconfig_eth0_with_ipv6') }
  end

  describe '#ips' do
    it 'should return appropriate objects' do
      expect(resolver.ips.map { |obj| obj.ip })
        .to eq(["131.252.209.153", "2610:10:20:209:212:3fff:febe:2201", "fe80::212:3fff:febe:2201"])
    end
  end

  describe '#netmask' do
    it 'should return a netmask' do
      expect(resolver.netmask('131.252.209.153')).to eq('255.255.255.0')
    end
  end

  describe '#mtu' do
    it 'should return a mtu' do
      expect(resolver.mtu).to eq('1500')
    end
  end

  describe '#aliased?' do
    it 'should return false' do
      expect(resolver.aliased?('198.245.51.174')).to be_falsey
    end
  end

end

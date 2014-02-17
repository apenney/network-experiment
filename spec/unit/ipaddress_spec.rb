require 'spec_helper'
require 'network'

describe 'Network::IPaddress' do
  let(:resolver) { double("Network::Resolver::Linux::Ip") }
  subject { Network::IPaddress.new('10.10.10.10', resolver) }

  it 'should return a name' do
    expect(subject.name).to eq('10.10.10.10')
  end

  it 'should return an interface' do
    subject.netmask = 'eth0'
    expect(subject.netmask).to eq('eth0')
  end

  it 'should return a netmask' do
    subject.netmask = '255.255.255.0'
    expect(subject.netmask).to eq('255.255.255.0')
  end

  it 'should return a mtu' do
    subject.mtu = '1500'
    expect(subject.mtu).to eq('1500')
  end

  it 'should return aliased?' do
    subject.aliased = true
    expect(subject.aliased?).to be_true
  end
end

require 'facter'

module Network::Resolver

  require 'network/resolver/linux'
  require 'network/resolver/linux/ip'

  #@@impl = case Facter.osfamily
  @@impl = case 'Linux'
           when 'Linux'
             Network::Resolver::Linux::Ip.new('eth0')
           end

  def self.impl
    @@impl
  end

  module_function

  def alias?(ip)
    @@impl.alias?(ip)
  end

  def interface
    @@impl.interface
  end

  def ips
    @@impl.ips
  end

  def netmask(ip)
    @@impl.netmask(ip)
  end

  def mtu
    @@impl.mtu
  end

end

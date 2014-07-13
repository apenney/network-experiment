module Network::Resolver

  require 'facter'
  require 'network/resolver/linux'
  require 'network/resolver/linux/ip'
  require 'network/resolver/linux/ifconfig'

  @@impl = case Facter.fact('kernel').value
           when 'Linux'
             if File.exists?('/sbin/ip')
               Network::Resolver::Linux::Ip.new('eth0')
             elsif File.exists?('/sbin/ifconfig')
               Network::Resolver::Linux::Ifconfig.new('eth0')
             else
               fail 'No resolver found'
             end
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

class Network::Resolver::Linux::Ip
  require 'ipaddr'

  attr_accessor :interface

  def initialize(interface)
    @interface = interface
  end

  def output
    @output ||= Facter::Util::Resolution.exec("/sbin/ip addr show #{@interface}")
  end

  def ips
    ips = output.scan(ip_regex).flatten
    ips.map { |ip| Network::IPaddress.new(ip, netmask(ip), self) }
  end

  def netmask(ip)
    if ip.match(Resolv::IPv4::Regex)
      mask = output.match(netmask_regex(ip))[1]
      return IPAddr.new('255.255.255.255').mask(mask).to_s
    else
      return output.match(netmask_regex(ip))[1]
    end
  end

  def mtu
    output.match(mtu_regex)[1]
  end

  def macaddress
    output.match(macaddress_regex)[1]
  end

  def alias?(ip)
    output.match(alias_regex(ip)) ? true : false
  end

  def ip_regex
    /inet6?\s(.*)\/+/
  end

  def netmask_regex(ip)
    /#{ip}\/(\d+)/
  end

  def macaddress_regex
    /link\/ether\s((\w{1,2}:?){6})/
  end

  def mtu_regex
    /mtu (\d+)/
  end

  def alias_regex(ip)
    /#{ip}.*:\d+$/
  end

end

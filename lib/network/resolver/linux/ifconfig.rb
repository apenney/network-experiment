class Network::Resolver::Linux::Ifconfig
  require 'resolv'

  attr_accessor :interface

  def initialize(interface)
    @interface = interface
  end

  def output
    @output ||= Facter::Util::Resolution.exec("/sbin/ifconfig #{@interface}")
  end

  def ips
    ips = output.scan(ip_regex).flatten
    ips.map { |ip| Network::IPaddress.new(ip, netmask(ip), self) }
  end

  def netmask(ip)
    regex = netmask_regex(ip)
    return output.match(regex)[1]
  end

  def mtu
    output.match(mtu_regex)[1]
  end

  def macaddress
    output.match(macaddress_regex)[1]
  end

  def aliased?(ip)
    output.match(alias_regex(ip)) ? true : false
  end

  def ip_regex
    /addr:\s?(.*?)[\s|\/]/
  end

  def netmask_regex(ip)
    if ip.match(Resolv::IPv4::Regex)
      /#{ip}.*Mask:(.*)$/
    elsif ip.match(Resolv::IPv6::Regex)
      /inet6 addr:\s.*?\/(\d+)/
    end
  end

  def macaddress_regex
    /HWaddr\s(.*)$/
  end

  def mtu_regex
    /MTU:(\d+)/
  end

  def alias_regex(ip)
    /#{ip}.*:\d+$/
  end

end

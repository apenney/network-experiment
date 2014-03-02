class Network::Resolver::Linux::Ip
  require 'ipaddr'

  attr_accessor :interface
  attr_reader :ips

  def initialize(interface)
    @interface = interface
    @ips       = ipaddresses
  end

  def output
    @output ||= Facter::Util::Resolution.exec("/sbin/ip addr show #{@interface}")
    @output
  end

  def ipaddresses
    ips = output.scan(ip_regex).flatten
    addresses = ips.map do |ip|
      Network::IPaddress.new(ip, self)
    end
    addresses
  end

  def netmask(ip)
    mask = output.match(netmask_regex(ip))[1]
    IPAddr.new('255.255.255.255').mask(mask).to_s
  end

  def mtu
    output.scan(mtu_regex).flatten
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

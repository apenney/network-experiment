class Network::IPaddress

  attr_accessor :ip, :netmask
  attr_reader   :resolver, :macaddress, :interface, :mtu, :aliased

  def initialize(ip, netmask, resolver)
    @ip       = ip
    @netmask  = netmask
    @resolver = resolver
  end

  def interface=(interface=@resolver.interface)
    @interface ||= interface
  end

  def mtu=(mtu=@resolver.mtu)
    @mtu ||= mtu
  end

  def macaddress=(macaddress=@resolver.macaddress)
    @macaddress ||= macaddress
  end

  def aliased=(aliased=@resolver.alias(@ip))
    @aliased ||= aliased
  end

  def aliased?
    @aliased
  end

end

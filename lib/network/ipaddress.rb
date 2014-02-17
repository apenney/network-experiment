class Network::IPaddress

  attr_accessor :name
  attr_reader   :resolver, :netmask, :interface, :mtu

  def initialize(name, resolver)
    @name     = name
    @resolver = resolver
  end

  def netmask=(netmask=@resolver.netmask(@name))
    @netmask ||= netmask
  end

  def interface=(interface=@resolver.interface)
    @interface ||= interface
  end

  def mtu=(mtu=@resolver.mtu)
    @mtu ||= mtu
  end

  def aliased=(aliased=@resolver.alias)
    @aliased ||= aliased
  end

  def aliased?
    @aliased
  end

end

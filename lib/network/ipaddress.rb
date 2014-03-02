class Network::IPaddress

  attr_accessor :name
  attr_reader   :resolver

  def initialize(name, resolver)
    @name     = name
    @resolver = resolver
  end

  def netmask
    @netmask ||= @resolver.netmask(@name)
  end

  def interface
    @interface ||= @resolver.interface
  end

  def mtu
    @mtu ||= @resolver.mtu
  end

  def alias?
    @alias ||= @resolver.alias?(@name)
  end

end

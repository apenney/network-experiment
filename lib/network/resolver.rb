require 'facter'
require 'network/resolver/linux'

class Network::Resolver

  case Facter.osfamily
    when 'Linux'
      include Network::Resolver::Linux
  end

end

require 'facter'

module Network::Resolver

  case Facter.osfamily
  when 'Linux'
    extends Network::Resolver::Linux
  end

end

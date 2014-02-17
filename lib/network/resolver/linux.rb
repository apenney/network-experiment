require 'network/resolver/linux/ip'

class Network::Resolver::Linux
  # case on /sbin/ip and /sbin/ifconfig or whatever.
  return Network::Resolver::Linux::Ip.new
end

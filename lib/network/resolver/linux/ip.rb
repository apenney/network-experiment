class Network::Resolver::Linux::Ip

  def ip(version)
    case version
      when '4'
        {
          :regex => /([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)/,
          :exec  => '/sbin/ip addr show',
          :token => 'inet ',
        }
      when '6'
        {
          :regex => /((?![fe80|::1])(?>[0-9,a-f,A-F]*\:{1,2})+[0-9,a-f,A-F]{0,4})/,
          :exec  => '/sbin/ip addr show',
          :token => 'inet6 ',
        }
    end
  end
end

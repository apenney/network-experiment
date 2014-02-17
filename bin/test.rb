#!/usr/bin/env ruby

require 'pry'
binding.pry
require Network::Interface

network = Network::Interface.new('eth0')

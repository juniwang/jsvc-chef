#
# Cookbook Name:: commons-daemon
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# We need jsvc for our service script to work correctly
case node['platform']
	when "debian", "ubuntu"
		package "jsvc"
	when "redhat", "centos", "fedora"
		if node[:commons_daemon][:use_yum]
			%w{jakarta-commons-daemon-jsvc jakarta-commons-daemon}.each do |pkg|
  				package pkg
  			end
  		else

  			include_recipe "build-essential" 

  			install_jsvc
  			install_commons_daemon_jar
		end
end
  
#
# Cookbook Name:: commons-daemon
# Recipe:: default
#
# Copyright 2014
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node['platform']
  when "debian", "ubuntu"
    package "jsvc"
  when "redhat", "centos", "fedora"
    if node[:commons_daemon][:use_yum]
      to_install = ['jakarta-commons-daemon-jsvc']
      to_install << 'jakarta-commons-daemon' if node[:commons_daemon][:install_commons_daemon_jar]
      to_install.each do |pkg|
        package pkg
      end
    else
      include_recipe "build-essential" 
      install_jsvc
      install_commons_daemon_jar if node[:commons_daemon][:install_commons_daemon_jar]
    end
end

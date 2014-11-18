#
# Author:: Junius Wang (<wangjunbo924@gmail.com>)
# Cookbook Name:: jsvc-cookbook
# Attribute:: default
#

default[:commons_daemon][:version] = "1.0.15"
default[:commons_daemon][:mirror] = "http://archive.apache.org/dist/commons/daemon"
# md5 for the source tarball
default[:commons_daemon][:source_md5] = "e467bc1f332d47ad85d18ea8b8a897c3"

# in addition to jsvc, is it needed to install the commons-daemon.jar?
default[:commons_daemon][:install_commons_daemon_jar] = true
# md5 for the commons-daemon jar file
default[:commons_daemon][:binary_md5] = "631bfc43cf5f601d34f1f5ea16751061"
default[:commons_daemon][:install_dir] = "/usr/share/java"

default[:commons_daemon][:use_yum] = false

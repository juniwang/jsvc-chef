class Chef
	class Recipe

		def install_jsvc
			tarball_path = "commons-daemon-#{node[:commons_daemon][:version]}-src.tar.gz"
			cache_tarball_path = "#{Chef::Config['file_cache_path']}/#{tarball_path}"
			jsvc_path = "/usr/bin/jsvc"
			chef_cache_path = Chef::Config['file_cache_path']

			remote_file "#{cache_tarball_path}" do
			  source "#{node[:commons_daemon][:mirror]}/source/#{tarball_path}"
			  mode 00644
			  checksum "#{node[:commons_daemon][:source_md5]}"
			  not_if { ::File.exists?(cache_tarball_path) }
			end

			bash "configure and build jsvc" do
				cwd chef_cache_path
				code <<-EOH
					tar zxvf #{tarball_path}
					export JAVA_HOME=#{node['java']['java_home']}
    				cd commons-daemon-#{node[:commons_daemon][:version]}-src/src/native/unix && ./configure
    				make
    				rm #{jsvc_path}
    				cp ./jsvc #{jsvc_path}
    				cd #{chef_cache_path}
    				rm -rf commons-daemon-#{node[:commons_daemon][:version]}-src
				EOH
				not_if { ::File.exists? (jsvc_path) && %x( jsvc -help | grep '#{node[:commons_daemon][:version]}') }
			end
		end

		def install_commons_daemon_jar
			
			jar_file = "commons-daemon-#{node[:commons_daemon][:version]}.jar"

			directory "#{node[:commons_daemon][:install_dir]}" do
			  mode "0755"
			  action :create
			  not_if { ::File.directory? (node[:commons_daemon][:install_dir])}
			end

			remote_file "#{node[:commons_daemon][:install_dir]}/#{jar_file}" do
			  source "#{node[:commons_daemon][:mirror]}/binaries/#{jar_file}"
			  checksum "#{node[:commons_daemon][:binary_md5]}"
			  not_if { ::File.exists? ("#{node[:commons_daemon][:install_dir]}/#{jar_file}") }
			end

			bash "configre apache commons daemon" do
				cwd node[:commons_daemon][:install_dir]
				code <<-EOH
					rm commons-daemon.jar*
					ln -s #{jar_file} commons-daemon.jar
				EOH
				not_if do
			        ::File.symlink?("#{node['commons_daemon']['install_dir']}/commons-daemon.jar") and
			        ::File.readlink("#{node['commons_daemon']['install_dir']}/commons-daemon.jar").include? node[:commons_daemon][:version]
			    end 
			end
		end
	end
end
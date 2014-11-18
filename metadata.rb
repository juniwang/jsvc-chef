name             'commons-daemon'
maintainer       'Autodesk'
maintainer_email 'junbo.wang@autodesk.com'
license          'All rights reserved'
description      'Installs/Configures commons-daemon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


%w{ debian ubuntu redhat centos fedora }.each do |os|
   supports os
end

depends		"java"
depends		"build-essential"

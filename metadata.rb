name             "opsworks_fixes"
maintainer       "Ryan Schlesinger"
maintainer_email "ryan@instanceinc.com"
license          "Apache 2.0"
description      "Installs/Configures opsworks_fixes"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends 'nginx'

%w{ centos redhat fedora amazon }.each do |os|
  supports os
end

recipe "opsworks_fixes", "Installs all opsworks fixes"
recipe "opsworks_fixes::upgrade_nginx", "Upgrades nginx to latest official release"
recipe "opsworks_fixes::install_epel_packages", "Installs rpm packages from EPEL"
recipe "opsworks_fixes::install_w_epel", "Installs rpm packages from EPEL; short recipe name"
recipe "opsworks_fixes::install_remote_packages", "Installs rpm packages from urls"
recipe "opsworks_fixes::install_w_remote", "Installs rpm packages from urls; short recipe name"


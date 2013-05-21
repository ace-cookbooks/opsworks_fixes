#
# Cookbook Name:: opsworks_fixes
# Recipe:: default
#

include_recipe 'opsworks_fixes::upgrade_nginx'
include_recipe 'opsworks_fixes::install_epel_packages'

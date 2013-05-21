if node[:remote_packages]
  node[:remote_packages].each do |name, pkg|
    full_name = "#{name}-#{pkg['version']}"
    rpm_name = "#{full_name}.rpm"

    remote_file "/tmp/#{rpm_name}" do
      source pkg['url']
      action :create_if_missing

      not_if do
        system("rpm -q #{name} | grep -q '#{full_name}'")
      end
    end

    rpm_package pkg['name'] do
      action :install
      source "/tmp/#{rpm_name}"

      not_if do
        system("rpm -q #{name} | grep -q '#{full_name}'")
      end
    end
  end
end

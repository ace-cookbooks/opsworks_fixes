if node[:remote_packages]
  node[:remote_packages].each do |pkg|
    full_name = "#{pkg['name']}-#{pkg['version']}"
    rpm_name = "#{full_name}.rpm"

    remote_file "/tmp/#{rpm_name}" do
      source pkg['rpm_url']
      action :create_if_missing

      not_if do
        system("rpm -q #{pkg['name']} | grep -q '#{full_name}'")
      end
    end

    rpm_package pkg['name'] do
      action :install
      source "/tmp/#{rpm_name}"

      not_if do
        system("rpm -q #{pkg['name']} | grep -q '#{full_name}'")
      end
    end
  end
end

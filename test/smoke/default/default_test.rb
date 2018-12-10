# # encoding: utf-8

# Inspec test for recipe http::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
# Checking the httpd service
if os[:family] == 'redhat'
  describe service('httpd') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

# Checking the ports
ports = [80, 443]
ports.each do |port|
  describe port(port) do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
    its('processes') { should include 'httpd' }
  end
end


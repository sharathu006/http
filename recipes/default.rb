#
# Cookbook:: http
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package "httpd" do
  action :install
end

file '/var/www/html/index.html' do
  content '<html>
  <body>
    <h1>hello world</h1>
  </body>
</html>'
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

bash "inline script" do
user "root"
code "mkdir -p /var/www/my-site && chown -R root /var/www/my-site"
not_if do
File.directory?('/var/www/my-site')
end
end 

execute "run a script" do
user "root"
command <<-EOF
useradd apache
chown -R apache /var/www/my-site
EOF
not_if
end

file '/etc/motd' do
content "This is a sharath test machine
hostname:  #{ node['hostname']}
ipaddress: #{ node['ipaddress']}
"
owner 'root'
group 'root'
action :create
end


service "httpd" do
  action [:enable, :start]
end

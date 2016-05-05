# Using JSON.parse(x.to_json) to convert Chef::Node::ImmutableArray and
# Chef::Node::ImmutableMash to plain Ruby array and hash.
# https://tickets.opscode.com/browse/CHEF-3953
# Also, convert port to integer since remote_syslog2 does not accept quoted port

file node['remote_syslog2']['config_file'] do
  content JSON.parse(node['remote_syslog2']['config'].to_hash.dup.to_json).to_yaml
  mode '0644'
  notifies :restart, 'service[remote_syslog2]', :delayed
end

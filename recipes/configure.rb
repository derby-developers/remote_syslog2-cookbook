file node['remote_syslog2']['config_file'] do
  content JSON.parse(node['remote_syslog2']['config'].to_hash.dup.to_json).to_yaml
  mode '0644'
  notifies :restart, 'service[remote_syslog2]', :delayed
end

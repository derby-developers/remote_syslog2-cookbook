install = node['remote_syslog2']['install']
bin_file = "#{install['bin_path']}/#{install['bin']}"

cookbook_file "remote_syslog_linux_i386.tar.gz" do
  path "/tmp/remote_syslog.tar.gz"
  action :create_if_missing
end

bash 'extract remote_syslog2' do
  cwd '/tmp'
  code <<-EOH
    mkdir -p #{install['extracted_path']}
    tar xzf #{install['download_path']} -C #{install['extract_path']}
    mv -f #{install['extracted_path']}/#{install['extracted_bin']} #{bin_file}
    rm -rf #{install['download_path']} #{install['extracted_path']}
  EOH
  not_if { ::File.exists?(bin_file) }
end

file bin_file do
  user 'root'
  group 'root'
  mode 0755
end

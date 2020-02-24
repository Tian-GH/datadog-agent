#
# Cookbook Name:: dd-agent-suse-inv
# Recipe:: default
#
# Copyright (C) 2013 Datadog
#
# All rights reserved - Do Not Redistribute
#

for i in 1..30 do
  ruby_block 'print ip a' do
    block do
      #tricky way to load this Chef::Mixin::ShellOut utilities
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
      res = shell_out('ip a')
      puts "stdout:"
      puts res.stdout
      puts "stderr:"
      puts res.stderr
    end
    action :create
  end

  ruby_block 'print ps aux' do
    block do
      #tricky way to load this Chef::Mixin::ShellOut utilities
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
      res = shell_out('ps axf -A -F')
      puts "stdout:"
      puts res.stdout
      puts "stderr:"
      puts res.stderr
    end
    action :create
  end

  ruby_block 'sample curl' do
    block do
      #tricky way to load this Chef::Mixin::ShellOut utilities
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)      
      res = shell_out('curl --fail https://yum.datadoghq.com/DATADOG_RPM_KEY_E09422B3.public')
      puts "stdout:"
      puts res.stdout
      puts "stderr:"
      puts res.stderr
    end
    action :create
  end

  execute 'sleep' do
    command <<-EOF
      sleep 3
    EOF
  end
end

ruby_block 'print azure agent log' do
  block do
    #tricky way to load this Chef::Mixin::ShellOut utilities
    Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
    res = shell_out('cat /var/log/waagent.log')
    puts "stdout:"
    puts res.stdout
    puts "stderr:"
    puts res.stderr
  end
  action :create
end
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

def load_current_resource
  @current_resource = Chef::Resource::PkgAdd.new(new_resource.name)
end

action :install do
  status = shell_out("pkg_info | grep #{new_resource.name}")
  if status.exitstatus == 1
    # grep did not find package name
    shell_out("pkg_add", new_resource.location)
  end
end

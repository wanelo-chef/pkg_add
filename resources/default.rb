
actions :install
default_action :install

attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :location, :kind_of => String, :required => true

require 'spec_helper'

describe 'pkg_add::default', 'validations' do
  before { double_cmd('pkg_add') }

  it 'requires :location' do
    exception_message = "Required argument location is missing"
    Chef::ExpectException.expect(Chef::Exceptions::ValidationFailed, /#{exception_message}/)

    expect {
      converge_recipe "pkg_add", %{
        pkg_add 'package_name' do
        end
      }
    }.to raise_error(Chef::Exceptions::ValidationFailed, /#{exception_message}/)
  end
end

describe 'pkg_add::default', 'install' do
  before { double_cmd('pkg_add') }

  context "package is not already installed" do
    before do
      double_cmd('pkg_info')
      double_cmd('grep package_name', exit: 1)
    end

    it 'runs pkg_add' do
      expect {
        converge_recipe "pkg_add", %{
          pkg_add 'package_name' do
            location "http://example.com/package.tgz"
          end
        }
      }.to shellout('pkg_add http://example.com/package.tgz')
    end
  end

  context 'package is already installed' do
    before do
      double_cmd('pkg_info')
      double_cmd('grep package_name', exit: 0)
    end

    it 'does nothing' do
      expect {
        converge_recipe "pkg_add", %{
          pkg_add 'package_name' do
            location "http://example.com/package.tgz"
          end
        }
      }.not_to shellout('pkg_add http://example.com/package.tgz')
    end
  end
end

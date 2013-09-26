pkg_add
=======

A Chef LWRP that allows you to install a pkgsrc package directly
from a .tgz file.

## Usage

```ruby
include_recipe "pkg_add"

pkg_add "lz4c" do
  location "http://us-east.manta.joyent.com/your_account/public/packages/lz4c-104.tgz"
  action :install
end
```

When running multiple times, the LWRP will use the `:name` attribute to determine
whether the package has already been installed (using `pkg_info`). `location` can be
a local path or a URI.


## Contributing

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github


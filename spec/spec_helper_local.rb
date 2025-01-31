# This is needed to test puppetlabs/acl on OSs other than Windows. If it's not
# present, then `pdk test unit` gives errors like:
#
# undefined method `symlink?' for Puppet::Util::Windows::File:Module
RSpec.configure do |c|
  c.mock_with :rspec do |mocks|
    # Necessary to use allow_any_instance_of
    mocks.syntax = [:expect, :should]
  end

  c.before :each do
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(
      Puppet::Type.type(:acl).provider(:windows),
    ).to(receive(:validate))
    # rubocop:enable RSpec/AnyInstance
  end
end

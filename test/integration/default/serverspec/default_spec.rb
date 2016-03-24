require 'spec_helper'

set :backend, :cmd
set :os, :family => 'windows'

describe 'cBitsServer website' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  it 'responds on port 81' do
    expect(port 80).to be_listening 'tcp'
  end
end

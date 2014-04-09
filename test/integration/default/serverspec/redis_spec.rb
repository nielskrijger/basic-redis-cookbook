require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "Redis Server" do

  it "is listening on port 6379" do
    expect(port(6379)).to be_listening
  end

  it "has a running service of redis" do
    expect(service("redis")).to be_running
  end

end
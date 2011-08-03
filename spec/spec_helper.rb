$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'rspec'
require 'hubway_muncher'
require 'httparty'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
end


# clumsily lifted from httparty
def file_fixture(filename)
  open(File.join(File.dirname(__FILE__), 'fixtures', "#{filename.to_s}")).read
end

def stub_http_response_with(filename)
  format = filename.split('.').last.intern
  data = file_fixture(filename)

  response = Net::HTTPOK.new("1.1", 200, "Content for you")
  response.stub!(:body).and_return(data)

  http_request = HTTParty::Request.new(Net::HTTP::Get, 'http://localhost', :format => format)
  http_request.stub_chain(:http, :request).and_return(response)

  HTTParty::Request.should_receive(:new).and_return(http_request)
end

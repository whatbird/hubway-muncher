require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "HubwayMuncher" do
  before do
    stub_http_response_with 'sample_20110802.xml'
  end
  it "should do it" do
    stations = HubwayMuncher.stations
    stations.count.should == 46
    stations.last.should be_a_kind_of(HubwayStation)
    stations.last.nbBikes.to_i.should > 0
  end
end

require 'spec_helper'

describe "materials/index" do
  before(:each) do
    assign(:materials, [
      stub_model(Material,
        :recipe => nil,
        :name => "Name",
        :amount => "Amount"
      ),
      stub_model(Material,
        :recipe => nil,
        :name => "Name",
        :amount => "Amount"
      )
    ])
  end

  it "renders a list of materials" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Amount".to_s, :count => 2
  end
end

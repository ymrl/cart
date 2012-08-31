require 'spec_helper'

describe "materials/show" do
  before(:each) do
    @material = assign(:material, stub_model(Material,
      :recipe => nil,
      :name => "Name",
      :amount => "Amount"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Amount/)
  end
end

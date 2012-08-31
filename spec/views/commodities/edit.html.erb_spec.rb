require 'spec_helper'

describe "commodities/edit" do
  before(:each) do
    @commodity = assign(:commodity, stub_model(Commodity,
      :jan => "MyString",
      :price => 1,
      :ingredient => nil,
      :weight => 1.5,
      :description => "MyText"
    ))
  end

  it "renders the edit commodity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => commodities_path(@commodity), :method => "post" do
      assert_select "input#commodity_jan", :name => "commodity[jan]"
      assert_select "input#commodity_price", :name => "commodity[price]"
      assert_select "input#commodity_ingredient", :name => "commodity[ingredient]"
      assert_select "input#commodity_weight", :name => "commodity[weight]"
      assert_select "textarea#commodity_description", :name => "commodity[description]"
    end
  end
end

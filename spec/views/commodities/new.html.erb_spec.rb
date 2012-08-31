require 'spec_helper'

describe "commodities/new" do
  fixtures :ingredients

  before(:each) do
    assign(:commodity, stub_model(Commodity,
      :price => 1,
      :ingredient_id => 1,
      :weight => 1.5,
      :description => "MyText"
    ).as_new_record)
    assign(:ingredients, Ingredient.all)
  end

  it "renders new commodity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => commodities_path, :method => "post" do
      assert_select "input#commodity_jan", :name => "commodity[jan]"
      assert_select "input#commodity_price", :name => "commodity[price]"
      assert_select "select#commodity_ingredient_id", :name => "commodity[ingredient_id]"
      assert_select "input#commodity_weight", :name => "commodity[weight]"
      assert_select "textarea#commodity_description", :name => "commodity[description]"
    end
  end
end

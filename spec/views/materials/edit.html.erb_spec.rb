require 'spec_helper'

describe "materials/edit" do
  before(:each) do
    @material = assign(:material, stub_model(Material,
      :recipe => nil,
      :name => "MyString",
      :amount => "MyString"
    ))
  end

  it "renders the edit material form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => materials_path(@material), :method => "post" do
      assert_select "input#material_recipe", :name => "material[recipe]"
      assert_select "input#material_name", :name => "material[name]"
      assert_select "input#material_amount", :name => "material[amount]"
    end
  end
end

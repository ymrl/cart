require 'spec_helper'

describe "ingredients/new" do
  before(:each) do
    assign(:ingredient, stub_model(Ingredient,
      :name => "MyString",
      :calorie => 1.5,
      :carbohydrates => 1.5,
      :protein => 1.5,
      :fat => 1.5,
      :carotene => 1.5,
      :vitamin_b1 => 1.5,
      :vitamin_b2 => 1.5,
      :vitamin_c => 1.5,
      :calcium => 1.5
    ).as_new_record)
  end

  it "renders new ingredient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ingredients_path, :method => "post" do
      assert_select "input#ingredient_name", :name => "ingredient[name]"
      assert_select "input#ingredient_calorie", :name => "ingredient[calorie]"
      assert_select "input#ingredient_carbohydrates", :name => "ingredient[carbohydrates]"
      assert_select "input#ingredient_protein", :name => "ingredient[protein]"
      assert_select "input#ingredient_fat", :name => "ingredient[fat]"
      assert_select "input#ingredient_carotene", :name => "ingredient[carotene]"
      assert_select "input#ingredient_vitamin_b1", :name => "ingredient[vitamin_b1]"
      assert_select "input#ingredient_vitamin_b2", :name => "ingredient[vitamin_b2]"
      assert_select "input#ingredient_vitamin_c", :name => "ingredient[vitamin_c]"
      assert_select "input#ingredient_calcium", :name => "ingredient[calcium]"
    end
  end
end

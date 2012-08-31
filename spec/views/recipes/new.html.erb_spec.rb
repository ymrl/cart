require 'spec_helper'

describe "recipes/new" do
  before(:each) do
    assign(:recipe, stub_model(Recipe,
      :title => "MyString",
      :image => "MyString",
      :url => "MyString",
      :time => "MyString",
      :calorie => 1.5
    ).as_new_record)
  end

  it "renders new recipe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recipes_path, :method => "post" do
      assert_select "input#recipe_title", :name => "recipe[title]"
      assert_select "input#recipe_image", :name => "recipe[image]"
      assert_select "input#recipe_url", :name => "recipe[url]"
      assert_select "input#recipe_time", :name => "recipe[time]"
      assert_select "input#recipe_calorie", :name => "recipe[calorie]"
    end
  end
end

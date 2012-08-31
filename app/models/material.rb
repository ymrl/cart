class Material < ActiveRecord::Base
  belongs_to :recipe
  attr_accessible :amount, :name,:recipe,:recipe_id
end

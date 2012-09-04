class Commodity < ActiveRecord::Base
  include CommoditiesHelper
  belongs_to :ingredient
  attr_accessible :description, :jan, :price, :weight, :ingredient, :ingredient_id,:producer
  validates :price, :presence => true
  validates :weight,:presence => true
  validates :jan,   :presence => true, :jan_code => true
  before_validation :set_jan

  def set_jan
    if !self.jan || self.jan == ""
      even = 0
      odd = 0
      str = "" 
      12.times do |i|
        num = nil
        if i==0
          num = 2
        elsif i == 1
          num = 9
        else
          num = (rand * 10).to_i
        end
        str += num.to_s
      end
      str += jancode_check(str).to_s
      self.jan = str
    end
  end

end

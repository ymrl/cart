#coding:UTF-8
class Tasks::InsertRecipes

  def self.execute

    require 'mechanize'

    agent = Mechanize.new
    agent.max_history = 5

    ingredients = Ingredient.all


    ingredients.each do |ingredient| 
      agent.get 'http://erecipe.woman.excite.co.jp/'
      agent.page.form('searchForm').field('word').value = ingredient.name
      puts "search #{ingredient.name}"
      agent.page.form('searchForm').submit

      # レシピタイトルのリンクを抽出。
      # 画像へのリンクがダブるのでtextが1文字以上のものを探す。
      recipe_links = agent.page.links_with(:href=>/^\/detail\//,:text=>/./)

      search_links = agent.page.links_with(:href=>/\/search\/.*page=/,:text=>/^\d+/)

      #puts 'get search link'
      #search_links.each do |search_link|
      #  search_link.click
      #  recipe_links += agent.page.links_with(:href=>/^\/detail\//,:text=>/./)
      #end

      recipe_links.each do |recipe_link|
        recipe_link.click

        puts recipe_link.text

        begin
          recipe = Recipe.create!(
            :title => recipe_link.text,
            :url   => recipe_link.uri.to_s,
            :time  => agent.page.search('.totaltime').text.gsub(/\s/,''),
            :image => agent.page.search('#ph_box .thumb img').attr('src').to_s.gsub(/&.*$/,''),
            :calorie => agent.page.search('.calories').text.to_f
          )
        rescue
          next
        end
        agent.page.link_with(:text=>/お買い物リスト/).click

        agent.page.search('.sp_disp').each do |e|
          name = e.css('.sp_material_name').text.gsub(/\s/,'')
          amount = e.css('.sp_material_amount').text.gsub(/\s/,'')
          Material.create!(
            :recipe => recipe,
            :name   => name,
            :amount => amount
          )
          if i = Ingredient.find_by_name(name)
            puts "RecipeIngredient creating #{name}"
            RecipeIngredient.create!(
              :recipe => recipe,
              :ingredient => i
            )
          end
        end
      end
    end
  end
end


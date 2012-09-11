class CommoditiesController < ApplicationController
  # GET /commodities
  # GET /commodities.json
  def index
    @commodities = Commodity.includes(:ingredient).all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commodities.map{|e|
          { :id            => e.id,
            :jan           => e.jan,
            :price         => e.price,
            :ingredient_id => e.ingredient_id,
            :weight        => e.weight,
            :description   => e.description,
            :created_at    => e.created_at,
            :updated_at    => e.updated_at,
            :producer      => e.producer,
            :favorites     => e.favorites,
            :name          => e.ingredient.name
        }
      }
    }
    end
  end

  # GET /commodities/1
  # GET /commodities/1.json
  def show
    @commodity = Commodity.find(params[:id])
    @ingredient = @commodity.ingredient

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: {
        :id            => @commodity.id,
        :jan           => @commodity.jan,
        :price         => @commodity.price,
        :ingredient_id => @commodity.ingredient_id,
        :weight        => @commodity.weight,
        :description   => @commodity.description,
        :created_at    => @commodity.created_at,
        :updated_at    => @commodity.updated_at,
        :favorites     => @commodity.favorites,
        :producer      => @commodity.producer,
        :name          => @ingredient.name,
        :calorie       => @ingredient.calorie       * @commodity.weight / 100,
        :carbohydrates => @ingredient.carbohydrates * @commodity.weight / 100,
        :protein       => @ingredient.protein       * @commodity.weight / 100,
        :fat           => @ingredient.fat           * @commodity.weight / 100,
        :carotene      => @ingredient.carotene      * @commodity.weight / 100,
        :vitamin_b1    => @ingredient.vitamin_b1    * @commodity.weight / 100,
        :vitamin_b2    => @ingredient.vitamin_b2    * @commodity.weight / 100,
        :vitamin_c     => @ingredient.vitamin_c     * @commodity.weight / 100,
        :calcium       => @ingredient.calcium       * @commodity.weight / 100,
      } 
    }
    end
  end

  # GET /commodities/new
  # GET /commodities/new.json
  def new
    @commodity = Commodity.new
    @ingredients = Ingredient.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @commodity }
    end
  end

  # GET /commodities/1/edit
  def edit
    @commodity = Commodity.find(params[:id])
    @ingredients = Ingredient.all
  end

  # POST /commodities
  # POST /commodities.json
  def create
    @commodity = Commodity.new(params[:commodity])
    @commodity.set_jan
    @ingredients = Ingredient.all

    respond_to do |format|
      if @commodity.save
        format.html { redirect_to @commodity, notice: 'Commodity was successfully created.' }
        format.json { render json: @commodity, status: :created, location: @commodity }
      else
        format.html { render action: "new" }
        format.json { render json: @commodity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /commodities/1
  # PUT /commodities/1.json
  def update
    @commodity = Commodity.find(params[:id])

    respond_to do |format|
      if @commodity.update_attributes(params[:commodity])
        format.html { redirect_to @commodity, notice: 'Commodity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @commodity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commodities/1
  # DELETE /commodities/1.json
  def destroy
    @commodity = Commodity.find(params[:id])
    @commodity.destroy

    respond_to do |format|
      format.html { redirect_to commodities_url }
      format.json { head :no_content }
    end
  end
  def search
    @commodity = Commodity.find_by_jan(params[:jan])
    @ingredient = @commodity.ingredient

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: {
        :id            => @commodity.id,
        :jan           => @commodity.jan,
        :price         => @commodity.price,
        :ingredient_id => @commodity.ingredient_id,
        :weight        => @commodity.weight,
        :description   => @commodity.description,
        :created_at    => @commodity.created_at,
        :updated_at    => @commodity.updated_at,
        :producer      => @commodity.producer,
        :favorites     => @commodity.favorites,
        :name          => @ingredient.name,
        :calorie       => @ingredient.calorie       * @commodity.weight / 100,
        :carbohydrates => @ingredient.carbohydrates * @commodity.weight / 100,
        :protein       => @ingredient.protein       * @commodity.weight / 100,
        :fat           => @ingredient.fat           * @commodity.weight / 100,
        :carotene      => @ingredient.carotene      * @commodity.weight / 100,
        :vitamin_b1    => @ingredient.vitamin_b1    * @commodity.weight / 100,
        :vitamin_b2    => @ingredient.vitamin_b2    * @commodity.weight / 100,
        :vitamin_c     => @ingredient.vitamin_c     * @commodity.weight / 100,
        :calcium       => @ingredient.calcium       * @commodity.weight / 100,
      } 
    }
    end
  end
  def favorite
    @commodity = Commodity.find(params[:id])
    @commodity.favorites += 1
    @ingredient = @commodity.ingredient
    respond_to do |format|
      if @commodity.save
          format.json { render json: {
            :id            => @commodity.id,
            :jan           => @commodity.jan,
            :price         => @commodity.price,
            :ingredient_id => @commodity.ingredient_id,
            :weight        => @commodity.weight,
            :description   => @commodity.description,
            :created_at    => @commodity.created_at,
            :updated_at    => @commodity.updated_at,
            :producer      => @commodity.producer,
            :favorites     => @commodity.favorites,
            :name          => @ingredient.name,
            :calorie       => @ingredient.calorie       * @commodity.weight / 100,
            :carbohydrates => @ingredient.carbohydrates * @commodity.weight / 100,
            :protein       => @ingredient.protein       * @commodity.weight / 100,
            :fat           => @ingredient.fat           * @commodity.weight / 100,
            :carotene      => @ingredient.carotene      * @commodity.weight / 100,
            :vitamin_b1    => @ingredient.vitamin_b1    * @commodity.weight / 100,
            :vitamin_b2    => @ingredient.vitamin_b2    * @commodity.weight / 100,
            :vitamin_c     => @ingredient.vitamin_c     * @commodity.weight / 100,
            :calcium       => @ingredient.calcium       * @commodity.weight / 100,
          }
        }
      else
        format.json { render json: @commodity.errors, status: :unprocessable_entity }
      end
    end
  end
  def nutrition
    @commodities = Commodity.joins(:ingredient).order("ingredients.#{params[:type]} desc").limit(3).select(%w|ingredients.name commodities.description commodities.favorites commodities.id commodities.jan commodities.price commodities.producer commodities.weight|)
    respond_to do |format|
      format.json { render json: @commodities}
    end
  end
  def popular
    @commodities = Commodity.joins(:ingredient).order("favorites desc").limit(3).select(%w|ingredients.name commodities.description commodities.favorites commodities.id commodities.jan commodities.price commodities.producer commodities.weight|)
    respond_to do |format|
      format.json { render json: @commodities}
    end
  end
end

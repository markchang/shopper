class ProductsController < ApplicationController
  before_filter :check_signed_in, except: [:index, :show]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      :autolink => true, :space_after_headers => true)
    @product = Product.find(params[:id])
    @product_markdown = markdown.render(@product.description).html_safe

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /mine
  # GET /mine.json
  def user_products
    @products = current_user.products

    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])

    redirect_to root_url, :notice => "Sorry, that isn't your product" unless current_user == @product.user
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    redirect_to root_url, :notice => "Sorry, that isn't your product" unless current_user == @product.user

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])

    redirect_to root_url, :notice => "Sorry, that isn't your product" unless current_user == @product.user

    # else, it is our product
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was destroyed' }
      format.json { head :no_content }
    end
  end
end

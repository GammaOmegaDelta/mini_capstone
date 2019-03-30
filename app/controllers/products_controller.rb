class ProductsController < ApplicationController
  def index
    @products = Product.all 
    render 'index.html.erb'
  end

  def show
    @product = Product.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def new
    @suppliers = Supplier.all
    render 'new.html.erb'
  end

  def create
    @product = Product.new(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      supplier_id: params[:supplier_id]
      )

    @product.save
    Image.create!(url: params[:image], product_id: @product.id)
    redirect_to "/products/#{@product.id}"
  end

  def edit
    @product = Product.find_by(:id)
    render 'edit.html.erb'
  end

  def update 
    @product = Product.find_by(id params[:id])
    @product.name = params[:title]
    @product.description = params[:description]
    @product.price = params[:price]
    @product.user_id = 1
    
    @product.save

    redirect_to "/products/#{@product.id}"
  end

  def destroy
    @product = Product.find_by(id: pararms[:id])
    @products.destroy
    redirect_to "/products"
  end
end
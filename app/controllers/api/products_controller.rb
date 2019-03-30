class Api::ProductsController < ApplicationController
  # before_action :authenticate_admin, only: [:create, :update, :destroy]
  # before_action :authenticate_user, only: [:show, :create]
  #before_action :authenticate_admin, except: [:index, :show]

  #everybody
  def index
    if params[:search]
      @products = Product.where("name LIKE ?", "%#{params[:search]}")
    else
      @products = Product.all
    end

    if params[:discount] == "true"
      @products = @products.where("price < ?", 2)
    end

    if params[:sort] && params[:sort_order]
      @products = @products.order(params[:sort] => params[:sort_order])
    end

    if params[:category]
      category = Category.find_by(name: params[:category])
      @products = category.products
    end
    render 'index.json.jbuilder'
  end

  #everybody
  def show
    p 'current_user'
    p current_user
    the_id = params[:id]
    @product = Product.find_by(id: the_id)
    render 'show.json.jbuilder'
  end

#only admins
  def create
    @product = Product.new(
      name: params[:name], 
      price: params[:price],
      description: params[:description],
      img_url: params[:img_url]
      )
    if @product.save
      #if user enters 'correct' info
      #data gets saved
      render 'show.json.jbuilder'
    else
    #   #if user enters 'incorrect' info 
    #   #data doesnt get saved
      render 'errors.json.jbuilder', status: :unprocessible_entity
    end
  end

  def update
    the_id = params[:id]
    @product = Product.find_by(id: the_id)
    @product.name = params[:name]
    @product.price = params[:price]
    @product.description = params[:description]
    @product.img_url = params[:img_url]
    if @product.save
      render 'show.json.jbuilder'
    else
      render 'errors.json.jbuilder'
    end
  end

  def destroy
    the_id = params[:id]
    @product = Product.find_by(id: the_id)
    @product.destroy
    render destroy.json.jbuilder
  end
end

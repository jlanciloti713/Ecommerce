class ProductsController < ApplicationController
    
    def index
        @products = Product.all.order(id: :asc)
    end

    def show
        @product = Product.find(params[:id])
    end

    def new
        
    end
    
    def create
        @product = Product.create(name: params[:name], price: params[:price], image_url: params[:image_url], description: params[:description])
        redirect_to ('/products')
    end

    def edit
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])
        @product.update(

                name: params[:name],
                price: params[:price],
                image_url: params[:image_url],
                description: params[:description]
            )

        redirect_to ("/products/#{@product.id}")
        # can also write it like Product.find(params[:id]).update(  name: params[:name],
        #         price: params[:price],
        #         image_url: params[:image_url],
        #         description: params[:description])
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        redirect_to ("/products")

        # can also do Product.find(params[:id]).destroy

    end
end

class ProductsController < ApplicationController
    
    def index
        # @products = Product.all.order(id: :asc)
    
        if params[:category] && params[:category].length > 2
          @category_name = params[:category]
          @category = Category.where('name LIKE ?', "%#{@category_name}%")[0]

          if @category != nil
            @products = @category.products
          else
            @products = []
          end
        elsif params[:category] && params[:category].length < 3
            @error_message = "Enter a category with 3 or more characters"
            @products = Product.all.order(id: :asc)
        else
          @products = Product.all.order(id: :asc)
        
    end

    end

    def show
        @carted_product = CartedProduct.new
        @product = Product.find(params[:id])
    end

    def new
        @product = Product.new
        @categories = Category.all
    end
    
    def create

        @product = Product.new(name: params[:name], price: params[:price], image_url: params[:image_url], description: params[:description])

        if @product.save
                @product.create_categories(params[:category_ids]) if params[:category_ids]
        
            redirect_to ('/products')
        else
            @categories = Category.all
            render 'new'
        end
    end

    def edit
        @product = Product.find(params[:id])
        @categories = Category.all
    end

    def update
        @product = Product.find(params[:id])
       
        if @product.update(

                name: params[:name],
                price: params[:price],
                image_url: params[:image_url],
                description: params[:description]
            )
            @product.update_categories(params[:category_ids]) if params[:category_ids]
                redirect_to ("/products/#{@product.id}")
        else
            @categories = Category.all
            render 'edit'
        end
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

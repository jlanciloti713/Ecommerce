class CartedProductsController < ApplicationController

    def create
        @carted_product = CartedProduct.new(

                                            amount: params[:amount],
                                            product_id: params[:product_id],
                                            is_purchased: false,
                                            is_removed: false
                                         )
        if @carted_product.save
            flash[:success] = "Product added to Cart"
            redirect_to "/products"
        else 
            flash[:warning] = "Enter greater amount"
            redirect_to "/products/#{params[:product_id]}"   
        end
    
    end

    def index
        @carted_products = CartedProduct.where(is_removed: false, is_purchased: false)
       
    end

    def update
        @carted_product = CartedProduct.find(params[:id])
        @carted_product.update(is_removed: true)

        redirect_to "/carted_products"
        # carted_product.is_removed = true
        # carted_product.save < will also work
    end

end

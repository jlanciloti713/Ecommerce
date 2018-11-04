class OrdersController < ApplicationController
    before_action :authenticate_user! 
    def index
        @orders = current_user.orders
    end
        


    def create
        products_in_cart = CartedProduct.where(is_removed: false, is_purchased: false, user_id: current_user.id)
        

        if products_in_cart.any?
            @my_order = Order.create
            products_in_cart.update_all(is_purchased: true, order_id: @my_order.id)
            flash[:success] = "Order placed!"
        else
            flash[:alert] = "Add some products to your Cart first!"
        end
        redirect_to "/products"
    end
        
    def show
        @order = Order.find(params[:id])
    end
       


end
    

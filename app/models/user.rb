class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :carted_products

  def products_in_cart
    carted_products.where(is_removed: false, is_purchased: false)
      
  end
end

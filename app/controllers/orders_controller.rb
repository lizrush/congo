class OrdersController < ApplicationController

  before_action :set_user, only: [:show]
  before_action :find_cart
    #:update, :destroy add later so that the user can cancel or update order before it ships

    def index
      @orders = Order.all
    end

    def show
      @orders = Order.all
    end

    def cart
      @order_item = @order.order_items
    end

    def checkout
    end

    def shipping_options
      weight = 0
      length = 0
      height = 0
      width  = 0
      @order.products.each do |product|
        weight += product.weight
        length += product.length
        height += product.height
        width  += product.width
      end
      options = { body:  {
                          packages: {
                                      width:  width,
                                      length: length,
                                      height: height,
                                      weight: weight
                           },
                           destination: {
                                         country:     @order.country,
                                         province:    @order.state,
                                         city:        @order.city,
                                         postal_code: @order.billing_zip
                                         }
                          } }
      HTTParty.post('http://localhost:4000/index.json', options )

    end

    def confirmation
      @shipping = []
      shipping_options.parsed_response["ups"].each do |r|
        r["price_in_cents"] = r["price_in_cents"].to_f/100
        @shipping << r.values.join(": $")
      end
      shipping_options.parsed_response["fedex"].each do |r|
        r["price_in_cents"] = r["price_in_cents"].to_f/100
        @shipping << r.values.join(": $")
      end
      @shipping
    end


    def add_to_cart
      @order_item = OrderItem.new(product_id: params[:product], order_id: @order.id, quantity: params[:order_item][:quantity])
      @order_item.save
      redirect_to cart_path
    end

    def update_cart
      @order_item = OrderItem.find(params[:order_item][:order_item_id])
      @order_item.quantity   = params[:order_item][:quantity]
      @order_item.save
      render :cart
    end

    def add_billing_info
      @order.update(order_params)
      if @order.save
        redirect_to confirmation_path
      end
    end

    def confirm
      @order = Order.find(session[:order_id])
      @order.update(status: "completed")
      if @order.save
        session[:order_id] = nil
        redirect_to :order_fulfillment
      else
        render :confirmation, notice: "Something went wrong."
      end
    end

  private
  def find_cart
    # begin find_cart

    if session[:order_id]
      @order = Order.find(session[:order_id])
    else
      if @current_user
        @order = Order.where(user_id: @current_user.id).where(status: "pending")
      end
    end

    if @order.nil?
      @order = Order.new
      @order.user_id = @current_user.id if @current_user
      @order.save
    end

    session[:order_id] = @order.id

    # end find_cart
  end

  def order_params
    params.require(:order).permit(:email, :street_address, :city, :state, :country, :name_on_cc, :cc_number, :cc_expiration, :cc_cvv, :billing_zip)
  end
end


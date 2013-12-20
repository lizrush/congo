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

<<<<<<< HEAD
    def cart
      @order_item = @order.order_items
    end
=======
  def cart
    @order_item = @order.order_items
  end
>>>>>>> master

  def checkout
  end

  def confirmation
    @old_order = @order
    @order = Order.new
    @order.user_id = @current_user.id if @current_user
    @order.save 
    session[:order_id] = @order.id
  end

  def add_to_cart
    # add_item_to_order(order = @order) EXAMPLE SAMPLE
    @order_item = OrderItem.new
    @order_item.product_id = params[:product]
    @order_item.order_id   = @order.id
    @order_item.quantity   = params[:order_item][:quantity] || 1
    @order_item.save
    redirect_to product_path(params[:product])
  end

<<<<<<< HEAD
    def update_cart
      @order_item = OrderItem.find(params[:order_item][:order_item_id])
      @order_item.quantity   = params[:order_item][:quantity] || 1
      @order_item.save
      render :cart
    end

    def add_billing_info
          @order.status = "completed"
          @order.email           = params[:email]
          @order.mailing_address = params[:mailing_address]
          @order.name_on_cc      = params[:name_on_cc]
          @order.cc_number       = params[:cc_number]
          @order.cc_expiration   = params[:cc_expiration]
          @order.cc_cvv          = params[:cc_cvv]
          @order.billing_zip     = params[:billing_zip]
          @order.save
      
          # session[:order_id] = nil
          redirect_to action: 'confirmation'
    end
=======
  def update_cart
    @order_item = OrderItem.find(params[:order_item][:order_item_id])
    @order_item.quantity   = params[:order_item][:quantity] || 1
    @order_item.save
    render :cart
    #new, create; cart=edit/ update=update - fix update?
  end

  def add_billing_info
    @order.status = "completed"
    @order.email           = params[:email]
    @order.mailing_address = params[:mailing_address]
    @order.name_on_cc      = params[:name_on_cc]
    @order.cc_number       = params[:cc_number]
    @order.cc_expiration   = params[:cc_expiration]
    @order.cc_cvv          = params[:cc_cvv]
    @order.billing_zip     = params[:billing_zip]
    @order.save
    
    # session[:order_id] = nil
    redirect_to action: 'confirmation' 
  end
  
>>>>>>> master

private
  def find_cart
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
  end
end


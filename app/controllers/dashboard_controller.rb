class DashboardController < ApplicationController
before_filter :authenticate_store!, :except => [:home]

  def home
    render :layout => 'home'
  end

  def main
  	@customers = current_store.customers.order("created_at DESC")
    if params[:customer_id]  
      session[:customer_id] = params[:customer_id] 
      session.delete :package_id  if session[:package_id]  
      if session[:package_id] 
      session.delete :package_id if Package.find(session[:package_id]).customer != Customer.find(params[:customer_id]) 
      end
    end
    @customer = Customer.find(params[:customer_id]) if params[:customer_id]  
    @packages = @customer.packages.order("end_date DESC") if @customer
    session[:package_id] = params[:package_id] if params[:package_id]     
    @package = Package.find(session[:package_id]) if session[:package_id]  
    if @packages
      if @packages.size == 1 
        @rentals = @packages.first.rentals.order("time DESC")
      end
    end
    if @package 
      @rentals = @package.rentals.order("time DESC")
    else
      @rentals = @customer.rentals.order("time DESC") if @customer
    end
        
  end
end

class RentalsController < ApplicationController

  before_filter :authenticate_store!  
  
  def index
    @rentals = Rental.where(:package_id => params[:package_id]) if params[:package_id]
  end

  def checkout
    @package = Package.find(params[:package_id])
    @rental = @package.rentals.build    
    @rental.time = Time.now
    @rental.in_or_out = 'out'
    @package.status = 'out'
    @boot = @package.boot
    @boot.in_store = false
    @ski = @package.ski
    @ski.in_store = false    
    respond_to do |format|
      if @rental.save && @package.save && @boot.save && @ski.save
        @rentals = @package.rentals
        format.js
      else
        format.js
      end
    end    
  end

  def checkin
    @package = Package.find(params[:package_id])
    @rental = @package.rentals.build    
    @rental.time = Time.now
    @rental.in_or_out = 'in'
    @package.status = 'in' 
    @boot = @package.boot
    @boot.in_store = true   
    @ski = @package.ski
    @ski.in_store = true     
    respond_to do |format|
      @rentals = @package.rentals 
      if @rental.save && @package.save && @boot.save && @ski.save
        format.js
      else
        format.js
      end
    end    
  end
  
  def new
    @package = Package.find(session[:package_id])
    @rental = @package.rentals.build
  end
  
  def create
    @package = Package.find(session[:package_id])
    @rental = @package.packages.build(params[:rental])
    respond_to do |format|
      if @rental.save           
        format.js
      else
        format.js
      end
    end
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def edit
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])    
    respond_to do |format|
      if @rental.update_attributes(params[:rental])
        format.js 
      else
        format.js
      end
    end
  end
  
  def destroy
    @rental = Rental.find(params[:id])
    @package = @rental.package
    @rental.destroy
    session.delete :rental_id
    redirect_to store_root_path
  end
  
end

class BootSizesController < ApplicationController
  # GET /boot_sizes
  # GET /boot_sizes.json
  def index
    @boot_sizes = BootSize.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boot_sizes }
    end
  end

  # GET /boot_sizes/1
  # GET /boot_sizes/1.json
  def show
    @boot_size = BootSize.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @boot_size }
    end
  end

  # GET /boot_sizes/new
  # GET /boot_sizes/new.json
  def new
    @boot_size = BootSize.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @boot_size }
    end
  end

  # GET /boot_sizes/1/edit
  def edit
    @boot_size = BootSize.find(params[:id])
  end

  # POST /boot_sizes
  # POST /boot_sizes.json
  def create
    @boot_size = BootSize.new(params[:boot_size])

    respond_to do |format|
      if @boot_size.save
        format.html { redirect_to @boot_size, notice: 'Boot size was successfully created.' }
        format.json { render json: @boot_size, status: :created, location: @boot_size }
      else
        format.html { render action: "new" }
        format.json { render json: @boot_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boot_sizes/1
  # PUT /boot_sizes/1.json
  def update
    @boot_size = BootSize.find(params[:id])

    respond_to do |format|
      if @boot_size.update_attributes(params[:boot_size])
        format.html { redirect_to @boot_size, notice: 'Boot size was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @boot_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boot_sizes/1
  # DELETE /boot_sizes/1.json
  def destroy
    @boot_size = BootSize.find(params[:id])
    @boot_size.destroy

    respond_to do |format|
      format.html { redirect_to boot_sizes_url }
      format.json { head :no_content }
    end
  end
end

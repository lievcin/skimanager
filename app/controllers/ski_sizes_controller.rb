class SkiSizesController < ApplicationController
  # GET /ski_sizes
  # GET /ski_sizes.json
  def index
    @ski_sizes = SkiSize.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ski_sizes }
    end
  end

  # GET /ski_sizes/1
  # GET /ski_sizes/1.json
  def show
    @ski_size = SkiSize.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ski_size }
    end
  end

  # GET /ski_sizes/new
  # GET /ski_sizes/new.json
  def new
    @ski_size = SkiSize.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ski_size }
    end
  end

  # GET /ski_sizes/1/edit
  def edit
    @ski_size = SkiSize.find(params[:id])
  end

  # POST /ski_sizes
  # POST /ski_sizes.json
  def create
    @ski_size = SkiSize.new(params[:ski_size])

    respond_to do |format|
      if @ski_size.save
        format.html { redirect_to @ski_size, notice: 'Ski size was successfully created.' }
        format.json { render json: @ski_size, status: :created, location: @ski_size }
      else
        format.html { render action: "new" }
        format.json { render json: @ski_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ski_sizes/1
  # PUT /ski_sizes/1.json
  def update
    @ski_size = SkiSize.find(params[:id])

    respond_to do |format|
      if @ski_size.update_attributes(params[:ski_size])
        format.html { redirect_to @ski_size, notice: 'Ski size was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ski_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ski_sizes/1
  # DELETE /ski_sizes/1.json
  def destroy
    @ski_size = SkiSize.find(params[:id])
    @ski_size.destroy

    respond_to do |format|
      format.html { redirect_to ski_sizes_url }
      format.json { head :no_content }
    end
  end
end

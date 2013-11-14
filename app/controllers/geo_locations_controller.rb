class GeoLocationsController < ApplicationController
  # GET /geo_locations
  # GET /geo_locations.json
  def index
    @geo_locations = GeoLocation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @geo_locations }
    end
  end

  # GET /geo_locations/1
  # GET /geo_locations/1.json
  def show
    @geo_location = GeoLocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @geo_location }
    end
  end

  # GET /geo_locations/new
  # GET /geo_locations/new.json
  def new
    @geo_location = GeoLocation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @geo_location }
    end
  end

  # GET /geo_locations/1/edit
  def edit
    @geo_location = GeoLocation.find(params[:id])
  end

  # POST /geo_locations
  # POST /geo_locations.json
  def create
    @geo_location = GeoLocation.new(params[:geo_location])

    respond_to do |format|
      if @geo_location.save
        format.html { redirect_to @geo_location, notice: 'Geo location was successfully created.' }
        format.json { render json: @geo_location, status: :created, location: @geo_location }
      else
        format.html { render action: "new" }
        format.json { render json: @geo_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /geo_locations/1
  # PUT /geo_locations/1.json
  def update
    @geo_location = GeoLocation.find(params[:id])

    respond_to do |format|
      if @geo_location.update_attributes(params[:geo_location])
        format.html { redirect_to @geo_location, notice: 'Geo location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @geo_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geo_locations/1
  # DELETE /geo_locations/1.json
  def destroy
    @geo_location = GeoLocation.find(params[:id])
    @geo_location.destroy

    respond_to do |format|
      format.html { redirect_to geo_locations_url }
      format.json { head :no_content }
    end
  end
end

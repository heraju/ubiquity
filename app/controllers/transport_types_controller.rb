class TransportTypesController < ApplicationController
  # GET /transport_types
  # GET /transport_types.json
  def index
    @transport_types = TransportType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transport_types }
    end
  end

  # GET /transport_types/1
  # GET /transport_types/1.json
  def show
    @transport_type = TransportType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transport_type }
    end
  end

  # GET /transport_types/new
  # GET /transport_types/new.json
  def new
    @transport_type = TransportType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transport_type }
    end
  end

  # GET /transport_types/1/edit
  def edit
    @transport_type = TransportType.find(params[:id])
  end

  # POST /transport_types
  # POST /transport_types.json
  def create
    @transport_type = TransportType.new(params[:transport_type])

    respond_to do |format|
      if @transport_type.save
        format.html { redirect_to @transport_type, notice: 'Transport type was successfully created.' }
        format.json { render json: @transport_type, status: :created, location: @transport_type }
      else
        format.html { render action: "new" }
        format.json { render json: @transport_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transport_types/1
  # PUT /transport_types/1.json
  def update
    @transport_type = TransportType.find(params[:id])

    respond_to do |format|
      if @transport_type.update_attributes(params[:transport_type])
        format.html { redirect_to @transport_type, notice: 'Transport type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transport_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transport_types/1
  # DELETE /transport_types/1.json
  def destroy
    @transport_type = TransportType.find(params[:id])
    @transport_type.destroy

    respond_to do |format|
      format.html { redirect_to transport_types_url }
      format.json { head :no_content }
    end
  end
end

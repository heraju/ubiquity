class TransportsController < ApplicationController
  # GET /transports
  # GET /transports.json
  def index
    @transports = Transport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transports }
    end
  end

  # GET /transports/1
  # GET /transports/1.json
  def show
    @transport = Transport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transport }
    end
  end

  # GET /transports/new
  # GET /transports/new.json
  def new
    @transport = Transport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transport }
    end
  end

  # GET /transports/1/edit
  def edit
    @transport = Transport.find(params[:id])
  end

  # POST /transports
  # POST /transports.json
  def create
    @transport = Transport.new(params[:transport])

    respond_to do |format|
      if @transport.save
        format.html { redirect_to @transport, notice: 'Transport was successfully created.' }
        format.json { render json: @transport, status: :created, location: @transport }
      else
        format.html { render action: "new" }
        format.json { render json: @transport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transports/1
  # PUT /transports/1.json
  def update
    @transport = Transport.find(params[:id])

    respond_to do |format|
      if @transport.update_attributes(params[:transport])
        format.html { redirect_to @transport, notice: 'Transport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transports/1
  # DELETE /transports/1.json
  def destroy
    @transport = Transport.find(params[:id])
    @transport.destroy

    respond_to do |format|
      format.html { redirect_to transports_url }
      format.json { head :no_content }
    end
  end
end

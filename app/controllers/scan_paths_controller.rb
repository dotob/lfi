class ScanPathsController < ApplicationController
  # GET /scan_paths
  # GET /scan_paths.json
  def index
    @scan_paths = ScanPath.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scan_paths }
    end
  end

  # GET /scan_paths/1
  # GET /scan_paths/1.json
  def show
    @scan_path = ScanPath.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scan_path }
    end
  end

  # GET /scan_paths/new
  # GET /scan_paths/new.json
  def new
    @scan_path = ScanPath.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scan_path }
    end
  end

  # GET /scan_paths/1/edit
  def edit
    @scan_path = ScanPath.find(params[:id])
  end

  # POST /scan_paths
  # POST /scan_paths.json
  def create
    @scan_path = ScanPath.new(params[:scan_path])

    respond_to do |format|
      if @scan_path.save
        format.html { redirect_to @scan_path, notice: 'Scan path was successfully created.' }
        format.json { render json: @scan_path, status: :created, location: @scan_path }
      else
        format.html { render action: "new" }
        format.json { render json: @scan_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scan_paths/1
  # PUT /scan_paths/1.json
  def update
    @scan_path = ScanPath.find(params[:id])

    respond_to do |format|
      if @scan_path.update_attributes(params[:scan_path])
        format.html { redirect_to @scan_path, notice: 'Scan path was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scan_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scan_paths/1
  # DELETE /scan_paths/1.json
  def destroy
    @scan_path = ScanPath.find(params[:id])
    @scan_path.destroy

    respond_to do |format|
      format.html { redirect_to scan_paths_url }
      format.json { head :no_content }
    end
  end
end

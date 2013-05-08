class CopyTargetsController < ApplicationController
  # GET /copy_targets
  # GET /copy_targets.json
  def index
    @copy_targets = CopyTarget.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @copy_targets }
    end
  end

  # GET /copy_targets/1
  # GET /copy_targets/1.json
  def show
    @copy_target = CopyTarget.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @copy_target }
    end
  end

  # GET /copy_targets/new
  # GET /copy_targets/new.json
  def new
    @copy_target = CopyTarget.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @copy_target }
    end
  end

  # GET /copy_targets/1/edit
  def edit
    @copy_target = CopyTarget.find(params[:id])
  end

  # POST /copy_targets
  # POST /copy_targets.json
  def create
    @copy_target = CopyTarget.new(params[:copy_target])
    @copy_target.save
    redirect_to "/conf"

  #  respond_to do |format|
  #    if @copy_target.save
  #      format.html { redirect_to @copy_target, notice: 'Copy target was successfully created.' }
  #      format.json { render json: @copy_target, status: :created, location: @copy_target }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @copy_target.errors, status: :unprocessable_entity }
  #    end
  #  end
  end

  # PUT /copy_targets/1
  # PUT /copy_targets/1.json
  def update
    @copy_target = CopyTarget.find(params[:id])

    respond_to do |format|
      if @copy_target.update_attributes(params[:copy_target])
        format.html { redirect_to @copy_target, notice: 'Copy target was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @copy_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /copy_targets/1
  # DELETE /copy_targets/1.json
  def destroy
    @copy_target = CopyTarget.find(params[:id])
    @copy_target.destroy

    redirect_to "/conf"
   # respond_to do |format|
   #   format.html { redirect_to copy_targets_url }
   #   format.json { head :no_content }
   # end
  end
end

class MentionsController < ApplicationController
  # GET /mentions
  # GET /mentions.json
  def index
    @mentions = Mention.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mentions }
    end
  end

  # GET /mentions/1
  # GET /mentions/1.json
  def show
    @mention = Mention.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mention }
    end
  end

  # GET /mentions/new
  # GET /mentions/new.json
  def new
    @mention = Mention.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mention }
    end
  end

  # GET /mentions/1/edit
  def edit
    @mention = Mention.find(params[:id])
  end

  # POST /mentions
  # POST /mentions.json
  def create
    @mention = Mention.new(params[:mention])

    respond_to do |format|
      if @mention.save
        format.html { redirect_to @mention, notice: 'Mention was successfully created.' }
        format.json { render json: @mention, status: :created, location: @mention }
      else
        format.html { render action: "new" }
        format.json { render json: @mention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mentions/1
  # PUT /mentions/1.json
  def update
    @mention = Mention.find(params[:id])

    respond_to do |format|
      if @mention.update_attributes(params[:mention])
        format.html { redirect_to @mention, notice: 'Mention was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @mention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentions/1
  # DELETE /mentions/1.json
  def destroy
    @mention = Mention.find(params[:id])
    @mention.destroy

    respond_to do |format|
      format.html { redirect_to mentions_url }
      format.json { head :ok }
    end
  end
end

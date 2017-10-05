class FactsController < ApplicationController
  before_action :set_fact, only: [:edit, :update, :destroy]

  # GET /facts
  # GET /facts.json
  def index
    @facts = Fact.all
  end

  # GET /facts/1
  # GET /facts/1.json
  def show
    if params[:id]=="random"
      # # Set a random offset
      # offset = rand(Fact.count)
      
      # # Get the random Fact
      # @fact = Fact.offset(offset).first
      @fact = Fact.random_fact
    else
      redirect_to facts_url
    end
  end

  # Custom Action for Top 10 Facts
  def top_10
    @facts = Fact.top10
  end

  # GET /facts/new
  def new
    @fact = Fact.new
  end

  # GET /facts/1/edit
  def edit
  end

  # POST /facts
  # POST /facts.json
  def create
    @fact = Fact.new(fact_params)

    # Strip fact of white spaces
    @fact.fact.strip!

    respond_to do |format|
      if @fact.save
        format.html { redirect_to @fact, notice: 'Fact was successfully created.' }
        format.json { render :show, status: :created, location: @fact }
      else
        format.html { render :new }
        format.json { render json: @fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facts/1
  # PATCH/PUT /facts/1.json
  def update
    respond_to do |format|
      if is_voting?

        # Add 1 vote to the fact
        vote = Vote.new
        vote.fact = @fact
        vote.save

        # Redirect to the Facts home page
        format.html { redirect_to facts_url }
        
      elsif @fact.update(fact_params)
        format.html { redirect_to @fact, notice: 'Fact was successfully updated.' }
        format.json { render :show, status: :ok, location: @fact }
      else
        format.html { render :edit }
        format.json { render json: @fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facts/1
  # DELETE /facts/1.json
  def destroy
    @fact.destroy
    respond_to do |format|
      format.html { redirect_to facts_url, notice: 'Fact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fact
      @fact = Fact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fact_params
      params.require(:fact).permit(:fact, :image)
    end

    def is_voting?
      params.require(:fact)[:vote].present?
    end
end

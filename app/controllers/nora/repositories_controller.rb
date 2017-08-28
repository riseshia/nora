class Nora::RepositoriesController < ApplicationController
  before_action :set_nora_repository, only: [:show, :edit, :update, :destroy]

  # GET /nora/repositories
  # GET /nora/repositories.json
  def index
    @nora_repositories = Nora::Repository.all
  end

  # GET /nora/repositories/1
  # GET /nora/repositories/1.json
  def show
  end

  # GET /nora/repositories/new
  def new
    @nora_repository = Nora::Repository.new
  end

  # GET /nora/repositories/1/edit
  def edit
  end

  # POST /nora/repositories
  # POST /nora/repositories.json
  def create
    @nora_repository = Nora::Repository.new(nora_repository_params)

    respond_to do |format|
      if @nora_repository.save
        format.html { redirect_to @nora_repository, notice: 'Repository was successfully created.' }
        format.json { render :show, status: :created, location: @nora_repository }
      else
        format.html { render :new }
        format.json { render json: @nora_repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nora/repositories/1
  # PATCH/PUT /nora/repositories/1.json
  def update
    respond_to do |format|
      if @nora_repository.update(nora_repository_params)
        format.html { redirect_to @nora_repository, notice: 'Repository was successfully updated.' }
        format.json { render :show, status: :ok, location: @nora_repository }
      else
        format.html { render :edit }
        format.json { render json: @nora_repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nora/repositories/1
  # DELETE /nora/repositories/1.json
  def destroy
    @nora_repository.destroy
    respond_to do |format|
      format.html { redirect_to nora_repositories_url, notice: 'Repository was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nora_repository
      @nora_repository = Nora::Repository.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nora_repository_params
      params.require(:nora_repository).permit(:name, :url)
    end
end

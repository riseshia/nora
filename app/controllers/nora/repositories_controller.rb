require_dependency 'nora/application_controller'

module Nora
  class RepositoriesController < ApplicationController
    # GET /repositories
    def index
      @repositories = Repository.all
    end

    # GET /repositories/new
    def new
      @repository = Repository.new
    end

    # POST /repositories
    def create
      @repository = Repository.new(repository_params)

      if @repository.save
        redirect_to @repository, notice: 'Repository was successfully created.'
      else
        render :new
      end
    end

    # DELETE /repositories/1
    def destroy
      @repository = Repository.find(params[:id])
      @repository.destroy
      redirect_to repositories_url, notice: 'Repository was successfully destroyed.'
    end

    private

    # Only allow a trusted parameter "white list" through.
    def repository_params
      params.require(:repository).permit(:name, :url)
    end
  end
end

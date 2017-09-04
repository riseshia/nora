require_dependency 'nora/application_controller'

module Nora
  class RepositoriesController < ApplicationController
    # GET /repositories
    def index
      @repositories = Repository.all
    end

    # GET /repositories/new
    def new
      @repositories = enable_repos.map do |repo|
        Repository.new(name: repo.full_name, url: repo.html_url)
      end
      Repository.all.pluck(:name).each do |existing_name|
        @repositories.delete_if {|repo| repo.name == existing_name }
      end
    end

    # POST /repositories
    def create
      params[:names].each do |name|
        repo = octokit_client.repository(name)
        Repository.register_hook!(octokit_client, repo)
      end
      redirect_to repositories_path, notice: 'Watching started.'
    end

    # DELETE /repositories/1
    def destroy
      repo = Repository.find(params[:id])
      Repository.unregister_hook!(octokit_client, repo)
      redirect_to repositories_url, notice: 'Repository was unregistered.'
    end

    private

    def enable_repos
      octokit_client.repositories.
        select { |r| r.permissions.admin }.delete_if(&:fork)
    end
  end
end

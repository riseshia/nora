require_dependency "nora/application_controller"

module Nora
  class ExecutionsController < ApplicationController
    # GET /executions
    def index
      @executions = Execution.includes(:nora_repository).all
    end

    # GET /executions/1
    def show
      @execution = Execution.find(params[:id])
    end

    # GET /executions/new
    def new
      @execution = Execution.new
    end

    # POST /executions
    def create
      @execution = Execution.new(execution_params)

      if @execution.save
        Nora::FindUnusedDiff.new.run(@execution)
        redirect_to @execution, notice: 'Execution was successfully created.'
      else
        render :new
      end
    end

    # DELETE /executions/1
    def destroy
      Execution.find(params[:id]).destroy
      redirect_to executions_url, notice: 'Execution was successfully destroyed.'
    end

    private
      # Only allow a trusted parameter "white list" through.
      def execution_params
        params.require(:execution).permit(
          :nora_repository_id, :pull_request_id, :base, :compare
        )
      end
  end
end

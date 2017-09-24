module Nora
  class FindUnusedDiffJob < ApplicationJob
    queue_as :default

    def perform(execution_id)
      execution = Execution.find(execution_id)
      Nora::FindUnusedDiff.new.run(execution)
    end
  end
end

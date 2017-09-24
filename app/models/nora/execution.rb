module Nora
  class Execution < ApplicationRecord
    belongs_to :nora_repository, foreign_key: :nora_repository_id, class_name: 'Nora::Repository'
    validates :nora_repository_id, presence: true
    validates :pull_request_id, presence: true
    validates :base, presence: true
    validates :compare, presence: true
  end
end

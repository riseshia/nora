module Nora
  class Repository < ApplicationRecord
    class << self
      def register_hook!(octokit_client, github_repo)
        repo_name = github_repo.full_name
        existing_hook = find_hook(octokit_client, repo_name)
        if existing_hook
          octokit_client.edit_hook(repo_name, existing_hook.id, 'web', hook_config, hook_options)
        else
          octokit_client.create_hook(repo_name, 'web', hook_config, hook_options)
        end
        create!(name: repo_name, url: github_repo.html_url)
      end

      def unregister_hook!(octokit_client, repo)
        hook = find_hook(octokit_client, repo.name)
        octokit_client.remove_hook(repo.name, hook.id) if hook
        repo.destroy!
      end

      def find_hook(octokit_client, repo_name)
        octokit_client.hooks(repo_name).find { |hook| hook.config.url == hooks_url }
      end

      def hook_config
        { content_type: 'json', url: hooks_url }
      end

      def hook_options
        { events: %w[issue_comment pull_request_review pull_request_review_comment] }
      end

      def hooks_url
        Nora::Engine.routes.url_helpers.hooks_url
      end
    end
  end
end

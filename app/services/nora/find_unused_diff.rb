module Nora
  class FindUnusedDiff
    def run(execution)
      repository = execution.nora_repository
      Dir.mktmpdir("nora_find_unused_diff_#{repository.id}") do |dir|
        repo_dir_path = Pathname.new(dir)
        project_path = Rails.root

        system!('git', 'clone', '--depth=1', repository.url + '.git', dir)

        base_diff = find_unused_to(project_path, dir)

        system!('git', 'fetch', 'origin', execution.remote_compare_branch)
        system!('git', 'checkout', execution.compare)
        compare_diff = find_unused_to(project_path, dir)

        # execution.update(completed: true, result: result)
      end
    end

    private

    def system!(*args)
      res = system(*args)
      raise "Command execution failure: #{args}" unless res
      res
    end

    def output_path(base_dir, filename)
      "#{base_dir}/tmp/#{filename}"
    end

    def find_unused_to(project_path, dir)
      gemfile_path = "#{project_path}/Gemfile"
      command = ['debride', '-r', dir]
      if File.exist?(gemfile_path)
        command.unshift("BUNDLE_GEMFILE=#{project_path}/Gemfile", 'bundle', 'exec')
      end
      system!(*command)
    end
  end
end

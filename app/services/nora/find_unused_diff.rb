require 'diffy'
require 'open3'

class Nora::FindUnusedDiff
  def run(execution)
    repository = execution.nora_repository
    Dir.mktmpdir("nora_find_unused_diff_#{repository.id}") do |dir|
      nora_path = Rails.root

      system!('git', 'clone', '--depth=1', repository.url + '.git', dir)
      base_diff = find_unused_to(nora_path, dir)

      Dir.chdir(dir) do
        system!('git', 'fetch', 'origin', execution.remote_compare_branch)
        system!('git', 'checkout', execution.compare)
      end
      compare_diff = find_unused_to(nora_path, dir)

      result = Diffy::Diff.new(base_diff, compare_diff).to_s.
        each_line.select { |line| line.start_with?('+') }.
        map { |line| line[2..-1] }.
        join("\n")
      execution.update(completed: true, result: result)
    end
  end

  private

  def system!(*args)
    res = system(*args)
    raise "Command execution failure: #{args}" unless res
    res
  end

  def system_on_dir!(dir, *args)
    args.unshift('cd', dir, '&&')
    system!(*args)
  end

  def output_path(base_dir, filename)
    "#{base_dir}/tmp/#{filename}"
  end

  def find_unused_to(nora_path, dir)
    gemfile_path = "#{nora_path}/Gemfile"
    command = ['debride', '-r', dir]
    if File.exist?(gemfile_path)
      command.unshift("BUNDLE_GEMFILE=#{nora_path}/Gemfile", 'bundle', 'exec')
    end
    o, _ = Open3.capture2(*command)
    o.gsub(dir + '/', '')
  end
end

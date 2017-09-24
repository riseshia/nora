require 'diffy'

module Nora
  class ExtractNewerDiffer
    def initialize(base_diff, compare_diff)
      @base_diff = base_diff
      @compare_diff = compare_diff
    end

    REGEXP = /^[+-]\s{2}/
    def process
      target_lines = Diffy::Diff.new(@base_diff, @compare_diff).to_s.
        each_line.select { |line| REGEXP.match?(line) }
      added, removed = target_lines.partition { |line| line.start_with?('+') }
      added = added.map { |line| line[3..-1] }
      removed = removed.map { |line| line[3..-1].split(':').first }
      added.reject { |line|
        info = line.split(':').first
        removed.include?(info)
      }.join("\n")
    end
  end
end

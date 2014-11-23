
require 'rspec/expectations'

NS = RSpec::Matchers

NS::define :be_a_repo_not_found_error_for do |owner_login, repo_name|
  match do |actual|
    return false unless actual.is_a?(Git::GitExecuteError)
    repo_url = sprintf 'https://github.com/%s/%s.git', owner_login, repo_name
    target_dir = File.expand_path repo_name
    lines = actual.message.split "\n"
    line1 = sprintf "git clone '--' '%s' '%s'.*", repo_url, target_dir
    matchers = [Regexp.new(line1)]
    matchers.push Regexp.new('remote: Repository not found.')
    line3 = sprintf "fatal: repository '%s/' not found", repo_url
    matchers.push Regexp.new(line3)

    return false unless matchers.count == lines.count
    lines.each_with_index do |line, index|
      return false unless line.match(matchers[index])
    end
    true
  end
end # RSpec::Matchers::define :be_a_repo_not_found_error_for

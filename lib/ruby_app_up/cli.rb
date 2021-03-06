
require 'thor'
require 'pastel'

require_relative 'description_maker'
require_relative 'repo'

# Module containing our Gem's logic.
module RubyAppUp
  # Command-line interface implementation for `ruby_app_up` Gem.
  class CLI < Thor
    desc 'init REPO_URL', 'This will pull down a Git repo and get it set up.'
    long_desc DescriptionMaker.new.long_description
    def init(repo_spec)
      user, repo_name = parse_repo_spec repo_spec
      @repo = Repo.new user, repo_name
      puts "Found GitHub repo '#{repo_spec}'!"
    end

    private

    def parse_repo_spec(repo_spec)
      user, repo_name = repo_spec.to_s.split '/'
      user = user.to_s.strip
      repo_name = repo_name.to_s.strip
      is_valid = user.length.nonzero? && repo_name.length.nonzero?
      fail Thor::MalformattedArgumentError, repo_spec_error unless is_valid
      [user, repo_name]
    end

    def repo_spec_error
      message = %w(ERROR: Repository must be specified in
                   login_name/repository_name format!).join(' ')
      Pastel.new.decorate message, :bright_red, :bold
    end
  end # class RubyAppUp::CLI
end # module RubyAppUp

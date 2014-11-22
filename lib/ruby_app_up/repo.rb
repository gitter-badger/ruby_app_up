
require 'github_api'

# Module containing our Gem's logic.
module RubyAppUp
  # Encapsulates a GitHub repo for purposes of this app.
  class Repo
    # Own error class; lets rescue specs be no more generalised than necessary.
    class NotFoundError < ArgumentError
      attr_reader :original_error, :user, :repo_name

      def initialize(user, repo_name, original_error)
        message = 'Invalid user name or repository specified: ' \
          "'#{user}/#{repo_name}'"
        @user = user
        @repo_name = repo_name
        @original_error = original_error
        super message
      end
    end

    def initialize(user, repo_name)
      @gh = Github.new build_gh_params
      repo = @gh.repos(user: user, repo: repo_name)
      begin
        @repo = repo.get
      rescue Github::Error::NotFound => e
        raise NotFoundError.new user, repo_name, e
      end
    end

    def owner_login
      @repo['owner']['login']
    end

    def name
      @repo['name']
    end

    private

    def build_gh_params
      ret = {}
      ret[:oauth_token] = ENV['OAUTH_TOKEN']
      ret.delete_if { |_, v| v.nil? }
    end
  end # class RubyAppUp::Repo
end # module RubyAppUp

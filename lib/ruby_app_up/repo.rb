
require 'git'

# Module containing our Gem's logic.
module RubyAppUp
  # Encapsulates a GitHub repo for purposes of this app.
  class Repo
    def initialize(user, repo_name)
      @gh = Git.clone build_uri_for(user, repo_name), repo_name,
                      path: Dir.getwd
    end

    def owner_login
      matches = parse_remote_url
      matches ? matches[1] : 'UNKNOWN_OWNER'
    end

    def name
      matches = parse_remote_url
      matches ? matches[2] : 'UNKNOWN_REPO'
    end

    private

    def build_uri_for(user, repo_name)
      sprintf 'https://github.com/%s/%s.git',
              CGI.escape(user.to_s),
              CGI.escape(repo_name.to_s)
    end

    def parse_remote_url
      r = Regexp.new 'https://github.com/(.+?)/(.+?)\.git'
      @gh.remote.url.match r
    end
  end # class RubyAppUp::Repo
end # module RubyAppUp

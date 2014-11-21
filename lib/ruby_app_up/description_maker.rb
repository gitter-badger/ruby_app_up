
# require 'colorize'

module RubyAppUp
  # Create text for Gem's `long_desc` string.
  class DescriptionMaker
    def long_description
      # 'init REPO_URL'.light_green + " will\x5" + massage_ld_lines.join("\x5")
      "init REPO_URL will\x5" + massage_ld_lines.join("\x5")
    end

    private

    def all_ld_lines # rubocop:disable Metrics/MethodLength
      [
        'EVE clone a Git repo (from a URL you MUST specify)',
        'EVE allow you to select the branch to clone, using the `--branch`' \
          ' command-line option (defaults to `master`)',
        'EVE cloning the repo to the subdirectory specified using the' \
          ' `--clone-to` command-line option (defaults to the default that' \
          ' Git uses, which is normally the bare repo name)',
        'EVE changes to the new project directory',
        'EVE rebundles the app, bundling into `./vendor` unless the' \
          ' `--no-bundle-vendor` command-line option is specified',
        "EVE runs `bundle package --all`, to cache the app's Gems for" \
          ' faster loading, unless the `--no-package` command line option is' \
          ' specified',
        'EVE runs `rbenv rehash`, to update any Gem-supplied binaries in' \
          ' the `rbenv` load path',
        'EVE runs `RAILS_ENV=test rake db:migrate db:reset db:seed` to' \
          ' initialise and seed the database, unless the `--no-setup-db`' \
          ' command-line option is specified; and finally',
        'EVE runs `rake` to run the default Rake task for the project,' \
          ' which normally runs RSpec, Rubocop and similar tools, unless the' \
          ' `--no-rake` command line option is specified.'
      ]
    end

    def ld_gsub_patterns
      {
        'EVE ' => 'EVENTUALLY ', # .light_magenta,
        # ' MUST ' => ' MUST '.light_red,
        # /`(.+?)`/ => '\1'.light_yellow
      }
    end

    # NOTE: Colorize (as of 0.7.3) scrambles output of a long string w/several
    #       embedded colour changes. If and when that Gem is fixed, remove the
    #       call to `current.uncolorize` on the last line of this method's inner
    #       block.
    def massage_ld_lines
      all_ld_lines.collect do |line|
        current = '* ' + line
        ld_gsub_patterns.each do |pattern, replacement|
          current = current.gsub pattern, replacement
        end
        current # .uncolorize
      end
    end
  end # class RubyAppUp::DescriptionMaker
end # module RubyAppUp

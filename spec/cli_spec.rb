
require 'spec_helper'
require 'pry'

require 'ruby_app_up/cli'
require 'ruby_app_up/colour_scheme'

# require_relative 'support/an_invalid_user_name_repo_spec'

def regexp_safe_for_colour(coloured, base)
  offset = coloured.index base
  ret = '.' * offset
  ret += base
  ret + '.' * (coloured.length - ret.length)
end

def match_for_possibly_coloured_str(actual, text)
  if text.nil? || text == actual
    actual
  else
    regexp_safe_for_colour actual, text
  end
end

# Module containing our Gem's logic.
module RubyAppUp
  describe CLI do
    let(:colours) { ColourScheme.new }

    describe :help.to_s do
      context 'with no parameters' do
        it 'outputs the correct general help text' do
          # Expected includes `rspec` as the command name because Thor sniffs
          # the running process name -- which for these tests *is* `rspec`.
          expected = "Commands:\n" \
              '  rspec help [COMMAND]  # Describe available commands or one' \
              " specific command\n" \
              '  rspec init REPO_URL   # This will pull down a Git repo and' \
              " get it set up.\n\n"
          expect { CLI.new.help }.to output(expected).to_stdout
        end
      end # context 'with no parameters'

      context 'with the parameter "init"' do
        it 'outputs the correct help text for the "init" command' do
          part = 'init REPO_URL'
          part = regexp_safe_for_colour(colours.command(part), part)
          expected_str = "Usage:\n  rspec init REPO_URL\n\n" \
            "Description:\n  #{part} will\n.+$"
          expected = Regexp.new expected_str, Regexp::MULTILINE
          expect { CLI.new.help 'init' }.to output(expected).to_stdout
        end
      end # context 'with the parameter "init"'

      context 'with the parameter "help"' do
        it 'outputs the correct help text for the "help" command' do
          expected = "Usage:\n" \
            "  rspec help [COMMAND]\n\n" \
            "Describe available commands or one specific command\n"
          expect { CLI.new.help 'help' }.to output(expected).to_stdout
        end
      end # context 'with the parameter "help"'

      context 'with an unsupported parameter' do
        it 'raises an UndefinedCommandError from Thor' do
          error_class = Thor::UndefinedCommandError
          message = 'Could not find command "foo".'
          expect { CLI.new.help 'foo' }.to raise_error error_class, message
        end
      end # context 'with an unsupported parameter'
    end # describe :help

    describe :init.to_s do
      context 'with a repo specifier that is invalid because it' do
        context 'has an invalid format' do
          it 'outputs the correct error message' do
            expected = 'ERROR: Repository must be specified in' \
              ' login_name/repository_name format!'
            begin
              CLI.new.init 'whatever'
            rescue Thor::MalformattedArgumentError => e
              expect(e.message).to eq Pastel.new.bright_red.bold(expected)
            end
          end
        end # context 'has an invalid format'

        context 'names an invalid Github user as the repo owner' do
          it 'outputs the correct error message' do
            owner_login = 'i_am_nobody'
            repo_name = 'anything-at-all'
            begin
              CLI.new.init [owner_login, repo_name].join('/')
            rescue StandardError => error
              expect(error).to be_a_repo_not_found_error_for owner_login,
                                                             repo_name
            end
          end
        end # context 'names an invalid Github user as the repo owner'
      end # context 'with a repo specifier that is invalid because it'

      context 'with a valid repo specifier' do
        it 'produces the correct output messages' do
          dirname = File.expand_path 'rspec-http'
          FileUtils.remove_dir dirname if Dir.exist? dirname
          message = "Found GitHub repo 'jdickey/rspec-http'!\n"
          expect { CLI.new.init 'jdickey/rspec-http' }.to output(message)
            .to_stdout
          FileUtils.remove_dir dirname if Dir.exist? dirname
        end
      end # context 'with a valid repo specifier'
    end # describe :init
  end # describe RubyAppUp::CLI
end # module RubyAppUp

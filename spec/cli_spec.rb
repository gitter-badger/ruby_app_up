
require 'spec_helper'
require 'stringio'
require 'awesome_print'
require 'pry'

require 'ruby_app_up/cli'

# Module containing our Gem's logic.
module RubyAppUp
  describe CLI do
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
          expected_str = "Usage:\n  rspec init REPO_URL\n\n" \
            "Description:\n  init REPO_URL will\n.+$"
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
        after :each do
          expect { CLI.new.init @param }.to raise_error @error, @message
        end

        context 'has an invalid format' do
          it 'outputs the correct error message' do
            @error = Thor::MalformattedArgumentError
            @message = 'ERROR: Repository must be specified in login_name/' \
              'repository_name format!'.light_red
            @param = 'whatever'
          end
        end # context 'has an invalid format'

        context 'names an invalid Github user as the repo owner' do
          it 'outputs the correct error message' do
            @param = 'i_am_nobody/anything'
            @error = RubyAppUp::Repo::NotFoundError
            @message = 'Invalid user name or repository specified:' \
              " 'i_am_nobody/anything'"
          end
        end # context 'names an invalid Github user as the repo owner'
      end # context 'with a repo specifier that is invalid because it'

      context 'with a valid repo specifier' do
        it 'produces the correct output messages' do
          message = "Found GitHub repo 'jdickey/rspec-http'!\n"
          expect { CLI.new.init 'jdickey/rspec-http' }.to output(message)
            .to_stdout
        end
      end # context 'with a valid repo specifier'
    end # describe :init
  end # describe RubyAppUp::CLI
end # module RubyAppUp

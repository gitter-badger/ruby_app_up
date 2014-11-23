
require 'spec_helper'

require 'ruby_app_up/repo'
require_relative 'support/an_invalid_user_name_repo_spec'

def repo_spec_cleanup(repo_name)
  subdir = File.expand_path CGI.escape(repo_name)
  FileUtils.remove_dir subdir if Dir.exist? subdir
  subdir
end

# Module containing our Gem's logic.
module RubyAppUp
  describe Repo do
    let(:klass) { Repo }
    let(:owner_login) { 'jdickey' }
    let(:repo_name) { 'tagtest' }

    describe :initialize.to_s do
      let(:obj) { klass.new owner_login, repo_name }

      before :each do
        @subdir = repo_spec_cleanup repo_name
      end

      after :each do
        repo_spec_cleanup repo_name
      end

      context 'with a valid Github login and repo specified' do
        it 'returns an object instance' do
          expect(obj).to be_a klass
        end

        it 'creates the project directory' do
          _ = obj
          expect(Dir.exist? @subdir).to be true
        end

        describe 'returns an object instance with the correct' do
          it 'owner login' do
            expect(obj.owner_login).to eq owner_login
          end

          it 'repo name' do
            expect(obj.name).to eq repo_name
          end
        end # describe 'returns an object instance with the correct'
      end # context 'with a valid Github login and repo specified'

      context 'with an invalid Github login specified' do
        let(:owner_login) { 'nobody_at_this_address' }
        let(:repo_name) { 'nothing_here' }

        it_behaves_like 'an invalid user name or repo specified'
      end # context 'with an invalid Github login specified'

      context 'with a valid Github login but an invalid repo name specified' do
        let(:owner_login) { 'jdickey' }
        let(:repo_name) { 'nothing_here' }

        it_behaves_like 'an invalid user name or repo specified'
      end # context 'with a valid Github login but an invalid repo name...'
    end # describe :initialize
  end # describe Repo
end # module RubyAppUp

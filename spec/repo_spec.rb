
require 'spec_helper'

require 'ruby_app_up/repo'

shared_examples 'an invalid user name or repo specified' do
  describe 'it raises an error that is a' do
    let(:error) do
      ret = nil
      begin
        obj
      rescue StandardError => e
        ret = e
      end
      ret
    end

    it 'RubyAppUp::Repo::NotFoundError' do
      expect(error).to be_a RubyAppUp::Repo::NotFoundError
    end

    describe 'RubyAppUp::Repo::NotFoundError with the correct' do
      it 'message' do
        message = 'Invalid user name or repository specified: ' \
          "'#{owner_login}/#{repo_name}'"
        expect(error.message).to eq message
      end

      it 'user attribute' do
        expect(error.user).to eq owner_login
      end

      it 'repo name' do
        expect(error.repo_name).to eq repo_name
      end
    end # describe 'RubyAppUp::Repo::NotFoundError with the correct'
  end # describe 'it raises an error that is a'
end # shared_examples 'an invalid user name or repo specified'

# Module containing our Gem's logic.
module RubyAppUp
  describe Repo do
    let(:klass) { Repo }
    let(:owner_login) { 'jdickey' }
    let(:repo_name) { 'tagtest' }

    describe :initialize.to_s do
      let(:obj) { klass.new owner_login, repo_name }

      context 'with a valid Github login and repo specified' do
        it 'returns an object instance' do
          expect(obj).to be_a klass
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

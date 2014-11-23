
require_relative 'be_a_repo_not_found_error_for'

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

    it 'Git::GitExecuteError with the correct message' do
      expect(error).to be_a_repo_not_found_error_for owner_login, repo_name
    end
  end # describe 'it raises an error that is a'
end # shared_examples 'an invalid user name or repo specified'

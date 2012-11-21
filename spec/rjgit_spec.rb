require 'spec_helper'

# Useful command git ls-tree HEAD

describe RubyGit do
  before(:all) do
    @temp_bare_repo_path = create_temp_repo(TEST_BARE_REPO_PATH)
    @bare_repo = Repo.new(@temp_bare_repo_path)
    @git = RubyGit.new(@bare_repo.repo)
  end
  
  context "delegating missing methods to the underlying jgit Git object" do
     it "should delegate the method to the JGit object" do
       @git.send(:rebase).should be_a org.eclipse.jgit.api.RebaseCommand # :rebase method not implemented in RubyGit, but is implemented in the underlying JGit object
     end
     
     it "should throw an exception if the JGit object does not know the method" do
       expect { @git.send(:non_existent_method) }.to raise_error(NoMethodError)
     end
  end
  
  after(:all) do
    remove_temp_repo(File.dirname(@temp_bare_repo_path))
  end
end
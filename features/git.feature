Feature: Browse Git Repository
 
  As the owner of my blog
  I want to be able to view all the files inside a git repository
  So that I can use local programs to write to my blog and be able to read my notes and files from any machine

  Background:
    Given I have set up a git repository by setting path to "." and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"

  Scenario: Able to view contents of git repository root directory
    When I am on the git_repos page
    And I follow "notes"
    Then I should see "test"

  Scenario: Map Urls to git repository paths
    When I visit "/files/notes/test/test-git-repo/personal/cooking"
    Then I should see "grill.mkdwn"

  Scenario: View contents of files
    When I visit "/files/notes/test/test-git-repo/personal/cooking/grill.mkdwn" 
    Then I should see "Aunt Debbie's famous bbq sauce"

  Scenario: Git Repository Doesn't exist
    When I visit "/files/no-where"
    Then I should see "Can't find git repository" 
    
  Scenario: Publish files inside git repositories to be available on the site
    When I visit "/files/notes/test/test-git-repo/personal/cooking/grill.mkdwn"
    And I press "Create and Publish"
    Then I should see "Node was successfully created"

  Scenario: Access git repositories via /files
    When I visit "/files"
    Then I should see "Listing git_repos"
    And I should see "notes"
    
  Scenario: Syncronize notes by pulling local git repo from remote location

  @dnr
  Scenario: Able to edit and commit files thru web
    When I visit "/files/notes/test/test-git-repo/personal/cooking/chilli-cheese-dogs.mkdwn"
    And I click "edit"
    And fill in the current time for "contents"
    And fill in "Commited from cucumber" for "commit_message"
    And I press "Update"
    And I visit "/files/notes/test/test-git-repo/personal/cooking/chilli-cheese-dogs.mkdwn"
    Then I should see that the file was updated with the current time

  Scenario: commit as different user
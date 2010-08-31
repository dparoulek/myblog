Feature: Browse Git Repository
 
  As the owner of my blog
  I want to be able to view all the files inside a git repository
  So that I can use local programs to write to my blog and be able to read my notes and files from any machine

  Scenario: Able to view contents of git repository root directory
    Given I have set up a git repository by setting path to "../tmp-git-repo" and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I am on the git_repos page
    And I follow "notes"
    Then I should see "todo.org"

  Scenario: Map Urls to git repository paths
    Given I have set up a git repository by setting path to "../tmp-git-repo" and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I visit "/files/notes/personal/cooking"
    Then I should see "grill.mkdwn"

  Scenario: View contents of files
    Given I have set up a git repository by setting path to "../tmp-git-repo" and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I visit "/files/notes/personal/cooking/grill.mkdwn" 
    Then I should see "Aunt Debbie's famous bbq sauce"

  Scenario: Git Repository Doesn't exist
    Given I have set up a git repository by setting path to "../tmp-git-repo" and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I visit "/files/no-where"
    Then I should see "Can't find git repository" 
    
  Scenario: Publish files inside git repositories to be available on the site
    Given I have set up a git repository by setting path to "../tmp-git-repo" and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I visit "/files/notes/personal/cooking/grill.mkdwn"
    And I press "Create and Publish"
    Then I should see "Node was successfully created"

  Scenario: Access git repositories via /files
    Given I have set up a git repository by setting path to "../tmp-git-repo" and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I visit "/files"
    Then I should see "Listing git_repos"
    And I should see "notes"
    
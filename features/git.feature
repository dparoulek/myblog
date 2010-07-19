Feature: Browse Git Repository
 
  As the owner of my blog
  I want to be able to view all the files inside a git repository
  So that I can use local programs to write to my blog and be able to read my notes and files from any machine

  Scenario: Able to view contents of git repository root directory
    Given I have set up a git repository inside "../tmp-git-repo"
    When I am on the git_repos page
    And I follow "notes"
    Then I should see "todo.org"

  Scenario: Map Urls to git repository paths
    Given I have set up a git repository inside "../tmp-git-repo"
    When I visit "/notes/personal/cooking"
    Then I should see "grill.mkdwn"

  Scenario: View contents of files
    Given I have set up a git repository inside "../tmp-git-repo"
    When I visit "/notes/personal/cooking/grill.mkdwn" 
    Then I should see "Aunt Debbie's famous bbq sauce"
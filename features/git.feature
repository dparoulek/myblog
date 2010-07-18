Feature: Browse Git Repository
 
  As the owner of my blog
  I want to be able to view all the files inside a git repository
  So that I can use local programs to write to my blog and be able to read my notes and files from any machine

  Scenario: 
    Given I have set up a git repository inside "~/notes"
    When I am on the git_repos page
    And I follow "notes"
    Then I should see "gtd.org" 
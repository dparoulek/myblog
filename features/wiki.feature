Feature: Wiki

  I want my blog to have wiki like functionality
  So that I can easily create new pages with notes

  Scenario: Browse to non-existent page
#     When I go to a page that doesn't exist
#     Then I should see "This page doesn't exist"

  Scenario: Display markdown files
    Given I have set up a git repository inside "../tmp-git-repo"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I am logged in
    When I visit "/notes/personal/cooking/grill.mkdwn" 
    Then I should see "Chicken" within "h1"

  Scenario: Display org files
    Given I have set up a git repository inside "../tmp-git-repo"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I am logged in
    When I visit "/notes/todo.org"
    Then I should see "Pick up milk, bread at grocery store" within "h1"

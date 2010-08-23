Feature: Wiki

  I want my blog to have wiki like functionality
  So that I can easily create new pages with notes

  Background:
    Given I have set up a git repository inside "../tmp-git-repo"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
  
  Scenario: Display markdown files
    When I visit "/notes/personal/cooking/grill.mkdwn" 
    Then I should see "Chicken"

  Scenario: Display org files
    When I visit "/notes/todo.org"
    Then I should see "Pick up milk, bread at grocery store"

  Scenario: Display public entries on home page
    Given I create a node named "Recipes" based on "personal/cooking/grill.mkdwn"
    When I follow "home"
    Then I should see "Recipes"
    And I should see "Aunt Debbie's famous bbq sauce"

  Scenario: Display publish dates of articles
    Given I create a node named "Recipes" based on "personal/cooking/grill.mkdwn"
    And I set the published_on to "Jun 10 2010 5:30pm"
    When I follow "home"
    Then I should see "posted on June 10, 2010"

  Scenario: Article Pagination
    Given I created nodes using
      | name   | git_repo_path                | git_repo_id | public |
      | Node1  | personal/cooking/grill.mkdwn |           1 | true   |
      | Node2  | personal/cooking/grill.mkdwn |           1 | true   |
      | Node3  | personal/cooking/grill.mkdwn |           1 | true   |
      | Node4  | personal/cooking/grill.mkdwn |           1 | true   |
      | Node5  | personal/cooking/grill.mkdwn |           1 | true   |
      | Node6  | personal/cooking/grill.mkdwn |           1 | true   |
      | Node7  | personal/cooking/grill.mkdwn |           1 | true   |
      | Node8  | personal/cooking/grill.mkdwn |           1 | true   |
      | Node9  | personal/cooking/grill.mkdwn |           1 | true   |
      | Node10 | personal/cooking/grill.mkdwn |           1 | true   |
    And I set number of nodes to display on a page to "2"
    When I follow "home"
    Then I should see "Node1"
    And I should see "Node2"
    And I should not see "Node6"
    And I should see "1 2 3 4 5"

  Scenario: View Article
    Given I create a node named "Recipes" based on "personal/cooking/grill.mkdwn"
    When I go to to the home page
    And I follow "Recipes"
    Then I should see "Aunt Debbie's famous bbq sauce"
  
  Scenario: About Page

  Scenario: Move git_repo files under /repo

  Scenario: Browse to non-existent page


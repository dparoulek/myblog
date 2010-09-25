Feature: Wiki

  I want my blog to have wiki like functionality
  So that I can easily create new pages with notes

  Background:
    Given I have set up a git repository by setting path to "." and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
  
  Scenario: Display markdown files
    When I visit "/files/notes/test/test-git-repo/personal/cooking/grill.mkdwn" 
    Then I should see "Chicken"

  Scenario: Display org files
    When I visit "/files/notes/test/test-git-repo/todo.org"
    Then I should see "Pick up milk, bread at grocery store"

  Scenario: Display public entries on home page
    Given I create a node named "Recipes" based on "test/test-git-repo/personal/cooking/grill.mkdwn"
    When I follow "home"
    Then I should see "Recipes"
    And I should see "Aunt Debbie's famous bbq sauce"

  Scenario: Display publish dates of articles
    Given I create a node named "Recipes" based on "test/test-git-repo/personal/cooking/grill.mkdwn"
    And I set the published_on to "Jun 10 2010 5:30pm"
    When I follow "home"
    Then I should see "2010.06.10"

  # This scenario needs work. I think the timestamps get created out 
  # of order and so the order of the nodes is always messed up
  @dnr
  Scenario: Article Pagination
    Given I created nodes using
      | name   | git_repo_path                                   | public |
      | Node1  | test/test-git-repo/personal/cooking/grill.mkdwn | true   |
      | Node2  | test/test-git-repo/personal/cooking/grill.mkdwn | true   |
      | Node3  | test/test-git-repo/personal/cooking/grill.mkdwn | true   |
      | Node4  | test/test-git-repo/personal/cooking/grill.mkdwn | true   |
      | Node5  | test/test-git-repo/personal/cooking/grill.mkdwn | true   |
      | Node6  | test/test-git-repo/personal/cooking/grill.mkdwn | true   |
      | Node7  | test/test-git-repo/personal/cooking/grill.mkdwn | true   |
      | Node8  | test/test-git-repo/personal/cooking/grill.mkdwn | true   |
      | Node9  | test/test-git-repo/personal/cooking/grill.mkdwn | true   |
      | Node10 | test/test-git-repo/personal/cooking/grill.mkdwn | true   |
    And I set number of nodes to display on a page to "2"
    When I visit "/home/latest"
    Then I should see "Node1"
    And I should see "Node2"
    And I should not see "Node6"
    And I should see "1 2 3 4 5"

  Scenario: View Article
    Given I create a node named "Recipes" based on "test/test-git-repo/personal/cooking/grill.mkdwn"
    When I go to to the home page
    And I follow "Recipes"
    Then I should see "Aunt Debbie's famous bbq sauce"

  Scenario: Previous Post
    Given I created nodes using
      | name    | git_repo_path                | public | 
      | Post 1  | test/test-git-repo/personal/cooking/grill.mkdwn | true   | 
      | Post 2  | test/test-git-repo/personal/cooking/grill.mkdwn | true   |    
    And that "Post 1" has earlier (or equal) publish_date than "Post 2"
    When I visit "home"
    And I should see "Post 2"
    And I follow "Previous Post"
    Then I should see "Post 1"

  Scenario: Friendly urls
    Given I created nodes using	
      | name    | git_repo_path                                   | public | friendly_url |
      | Post 1  | test/test-git-repo/personal/cooking/grill.mkdwn | true   | post_1       |
    When I visit "post_1"
    Then I should see "famous bbq sauce"

  Scenario: All Posts

  Scenario: About Page

  Scenario: Browse to non-existent page

  Scenario: Able to tag nodes

  Scenario: What if git file moves?
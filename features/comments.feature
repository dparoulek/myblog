Feature: Comments
  In order to encourage audience participation and feedback to my site
  As an author
  I want others to be able to provide comments

  Background:
    Given I have set up a git repository by setting path to "." and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I create a node named "Recipes" based on "test/test-git-repo/personal/cooking/grill.mkdwn"
    Then I follow "Logout"

  Scenario: Must enter captcha to leave comment
    When I go to the home page
    And I follow "Recipes"
    And I fill in "Dave" for "comment_username"
    And I fill in "We made the sauce last night and it was delicious!" for "comment_comment"
    And I fill in the correct captcha
    And I press "submit"
    Then I should see "Thanks for your comment!"
    And I should see "We made the sauce last night and it was delicious!"
    And I should not see "Parent"

  Scenario: Must complete captcha in order to leave comment
    When I go to the home page
    And I follow "Recipes"
    And I fill in "Dave" for "comment_username"
    And I fill in "We made the sauce last night and it was delicious!" for "comment_comment"
    And I fill in an incorrect captcha
    And I press "submit"
    Then I should see "DOH! Unable to create new comment until the following problems are fixed:The characters you entered didn't quite match up to the image"

  Scenario: If comment or aptcha is entered incorrectly, then allow user to fix errors
    Given I go to the home page
    And I follow "Recipes"
    And I fill in "We made the sauce last night and it was delicious!" for "comment_comment"
    And I fill in the correct captcha
    And I press "submit"
    And I should see "Username can't be blank"
    When I fill in "Dave" for "comment_username"
    And I fill in the correct captcha
    And I press "submit"
    Then I should see "Thanks for your comment!"
    And I should see "We made the sauce last night and it was delicious!"
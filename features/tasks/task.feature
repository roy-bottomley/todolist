Feature: Task
  A signed in user should be able to
  add, delete and edit tasks once they
  have selected a tasklist

  @javascript
    Scenario: User adds a valid task
      Given I exist as a user
        And I have a tasklist "my tasklist"
        And I am logged in
       Then I should see the "my tasklist" task list
       When I select the tasklist "my tasklist"
       When I add a valid task
       Then I should see the valid task
        And The new task editor should be empty

  @javascript
    Scenario: User adds then deletes a task
      Given I exist as a user
      And I have a tasklist "my tasklist"
      And I am logged in
      When I select the tasklist "my tasklist"
      When I add a task  "cucumber_task"
      Then I should see the "cucumber_task" task
      And  The new task editor should be empty
     When  I delete the task "cucumber_task"
     Then  I should not see the "cucumber_task" task

  @javascript
    Scenario: User adds then edits a task
      Given I exist as a user
        And I have a tasklist "my tasklist"
        And I am logged in
       When I select the tasklist "my tasklist"
       When I add a task  "cucumber_task"
       Then I should see the "cucumber_task" task
      When  I edit the task "cucumber_task"
      Then  The task editor should contain "cucumber_task"
      When  I change the task name to "edited_task" and click save
      Then  I should not see the "cucumber_task" task
      And   I should see the "edited_task" task
      And   The task editor should be empty

  @javascript
    Scenario: User views tasks in several tasklists
      Given I exist as a user
      And   I have three tasklists
      And   I am logged in
      When  I select the tasklist "tl1"
      Then  I should see the tasks belonging to tasklist "tl1"
      When  I select the tasklist "tl1"
      Then  I should see the tasks belonging to tasklist "tl1"
      When  I select the tasklist "tl1"
      Then  I should see the tasks belonging to tasklist "tl1"

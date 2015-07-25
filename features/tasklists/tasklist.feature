Feature: Tasklist
  A signed in user should be able to
  add, delete and edit tasklists

  @javascript
    Scenario: User adds a valid tasklist
      Given I am logged in
       Then I should be signed in
       When I add a valid task list
       Then I should see the valid task list

  @javascript
    Scenario: User adds tasklist with a name
      Given I am logged in
      Then I should be signed in
      When I add a task list "cucumber_task_list"
      Then I should see the "cucumber_task_list" task list
      And  The input editor should be empty

  @javascript
    Scenario: User adds then deletes a tasklist
      Given I am logged in
      And   I add a task list "cucumber_task_list"
      Then  I should see the "cucumber_task_list" task list
      When  I delete the task list "cucumber_task_list"
      Then  I should not see the "cucumber_task_list" task list

  @javascript
    Scenario: User adds then edits a tasklist
    Given I am logged in
      And   I add a task list "cucumber_task_list"
      Then  I should see the "cucumber_task_list" task list
      When  I edit the task list "cucumber_task_list"
      Then  The editor should contain "cucumber_task_list"
      When  I change the name to "edited_task_list" and click save
      Then  I should not see the "cucumber_task_list" task list
      And   I should see the "edited_task_list" task list
      And   The editor should be empty

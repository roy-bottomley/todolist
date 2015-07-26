def create_user
  @user = FactoryGirl.create(:user)
end

def create_valid_task
  @valid_task ||= { description:  "a_valid_task", priority: 0, due_date: 'Date.today + 1.day'}
end

def add_tasklist(name, number_of_tasks)
  tl = @user.task_lists.create(name: name)
  number_of_tasks.times do |i|
    tl.tasks.create(description: "#{name} task #{i}")
  end
end

def active_editor_for_task
  begin
    find(:xpath,"//div[contains(@class,'task-section')]/ul//textarea")
  rescue
    nil
  end
end

def click_save_for_edited_task
  find(:xpath,"//div[contains(@class,'task-section')]/ul//button[text() = 'Save']").click()
end

def click_delete_for_task description
  find(:xpath,"//div[contains(@class,'task-section')]/ul//*[text()[contains(.,'#{description}')]]/..//button[text() = 'Delete']").click()
end

def click_edit_for_task description
  find(:xpath,"//div[contains(@class,'task-section')]/ul//*[text()[contains(.,'#{description}')]]/..//button[text() = 'Edit']").click()
end

When(/^I select the tasklist "([^"]*)"$/) do |tasklist_name|
  item = find(:xpath,"//div[contains(@class,'tasklist-section')]//ul//*[text()[contains(.,'#{tasklist_name}')]]")
  item.click()
end


When(/^I add a valid task$/) do
  create_valid_task
  create_valid_tasklist
  fill_in "taskNewDescription", :with => @valid_tasklist[:name]
  click_button "Add New Task"
  wait_for_ajax
end

Then(/^I should see the valid task$/) do
  expect(page.body).to have_content(@valid_task[:desciption])
end

And(/^I have a tasklist "([^"]*)"$/) do |tasklist_name|
  @user.task_lists.create(name: tasklist_name)
end

And(/^I have three tasklists$/) do
  add_tasklist('tl1', 2)
  add_tasklist('tl2', 3)
  add_tasklist('tl3', 4)
end

When(/^I add a task  "([^"]*)"$/) do |task_description|
  fill_in "taskNewDescription", with: task_description
  click_button "Add New Task"
  wait_for_ajax
end

def check_view_task task
  expect(page.body).to have_content(task.description)
end

Then(/^I should see the "([^"]*)" task$/) do |task_description|
  expect(page.body).to have_content(task_description)
end

Then(/^I should see the tasks belonging to tasklist "([^"]*)"$/) do |name|
  tasklist = @user.task_lists.where(name: name).first
  tasklist.tasks.each{|task| check_view_task(task)}
end

Then(/^I should not see the "([^"]*)" task$/) do |task_description|
  expect(page.body).to_not have_content(task_description)
end

And(/^The new task editor should be empty$/) do
  expect(find("#taskNewDescription").value).to eq ''
end

When(/^I delete the task "([^"]*)"$/) do |task_description|
  click_delete_for_task   task_description
  handleAlert
  wait_for_ajax
end

When(/^I edit the task "([^"]*)"$/) do |task_description|
  click_edit_for_task task_description
end

Then(/^The task editor should contain "([^"]*)"$/) do |task_description|
  expect(active_editor_for_task.value).to eq task_description
end

And(/^The task editor should be empty$/) do
  expect(active_editor_for_task).to be nil
end

When(/^I change the task name to "([^"]*)" and click save$/) do |new_description|
  active_editor_for_task.set(new_description)
  click_save_for_edited_task
  wait_for_ajax
end



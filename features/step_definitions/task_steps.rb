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

When(/^I select the tasklist "([^"]*)"$/) do |tasklist_name|
  item = find(:xpath,"//div[contains(@class,'tasklist-section')]/*/*[text()[contains(.,'#{tasklist_name}')]]")
  item.click()
end


When(/^I add a valid task$/) do
  create_valid_task
  fill_in "taskNewDescription", with: @valid_task[:description]
  click_button "Add Task"
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
  click_button "Add Task"
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
  item = find(:xpath,"//*[text()[contains(.,'#{task_description}')]]/button[2]")
  item.click()
  handleAlert
  wait_for_ajax
end

When(/^I edit the task "([^"]*)"$/) do |task_description|
  item = find(:xpath,"//*[text()[contains(.,'#{task_description}')]]/button[1]")
  item.click()
end

Then(/^The task editor should contain "([^"]*)"$/) do |task_description|
  expect(find("#taskEditorDescription").value).to eq task_description
end

And(/^The task editor should be empty$/) do
  expect(find("#taskEditorDescription").value).to eq ''
end

When(/^I change the task name to "([^"]*)" and click save$/) do |new_description|
  fill_in "taskEditorDescription", with: new_description
  item = find(:xpath,"//div[contains(@class,'task-section')]/button[text() = 'Save']")
  item.click()
  wait_for_ajax
end



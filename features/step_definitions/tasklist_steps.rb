def wait_for_ajax
  counter = 0
  sleep(1)
  while page.execute_script("return $.ajax.active").to_i > 0
    counter += 1
    sleep(0.1)
    raise "AJAX request took longer than 5 seconds." if counter >= 50
  end
end

def handleAlert
  page.driver.browser.switch_to.alert.accept
end

def create_valid_tasklist
  @valid_tasklist ||= { name:  "a_valid_tasklist", priority: 0}
end

def active_editor_for_tasklist
  begin
    find(:xpath,"//div[contains(@class,'tasklist-section')]/ul//input")
  rescue
    nil
  end
end

def click_save_for_edited_tasklist
  find(:xpath,"//div[contains(@class,'tasklist-section')]/ul//button[text() = 'Save']").click()
end

When(/^I add a valid task list$/) do
  create_valid_tasklist
  fill_in "tasklistNewName", :with => @valid_tasklist[:name]
  click_button "Add New Tasklist"
  wait_for_ajax
end

Then(/^I should see the valid task list$/) do
  expect(page.body).to have_content(@valid_tasklist[:name])
end

When(/^I add a task list "([^"]*)"$/) do |tasklist_name|
  fill_in "tasklistNewName", :with => tasklist_name
  click_button "Add New Tasklist"
  wait_for_ajax
end

Then(/^I should see the "([^"]*)" task list$/) do |tasklist_name|
  expect(page.body).to have_content(tasklist_name)
end

And(/^The input editor should be empty$/) do
  expect(find("#tasklistNewName").text).to eq ''
end

When(/^I delete the task list "([^"]*)"$/) do |arg|
  click_button "Delete"
  handleAlert
  wait_for_ajax
end

Then(/^I should not see the "([^"]*)" task list$/) do |tasklist_name|
  expect(page.body).to_not have_content(tasklist_name)
end

When(/^I edit the task list "([^"]*)"$/) do |arg|
  click_button "Edit"
end

Then(/^The editor should contain "([^"]*)"$/) do |tasklist_name|
  expect(active_editor_for_tasklist.value).to eq tasklist_name
end

When(/^I change the name to "([^"]*)" and click save$/) do |new_name|
  active_editor_for_tasklist.set(new_name)
  click_save_for_edited_tasklist
  wait_for_ajax
end

And(/^The editor should be empty$/) do
  expect(active_editor_for_tasklist).to be nil
end


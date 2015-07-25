When(/^I visit the site and click Sign Up link$/) do
  goto_root
  click_link "Sign Up"
end

Then(/^I should see a sign up form$/) do
  page.should have_content "Sign Up"
  page.should have_content "Email"
  page.should have_content "Password again please"
end

When(/^I fill in my details correctly$/) do
  fill_in "Email", with: "admin123@roy.com"
  fill_in "user_password", with: "Admin123"
  fill_in "user_password_confirmation", with: "Admin123"
  #save_and_open_page
  click_button "Sign Up"
  page.should have_content("IPN")
  goto_root
  step  "I should be signed up"
end

Then(/^I should be signed up$/) do
  page.should have_content "Logout"           # be sure we are logged in
  page.should have_content("Loaded")        ## waits for TEST to appear
end


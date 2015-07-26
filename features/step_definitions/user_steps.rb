

def create_visitor
  @visitor ||= { :email => "example@example.com",
    :password => "changeme", :password_confirmation => "changeme" }
end

def find_user
  @user ||= create_user
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  #fill_in "user_name", :with => @visitor[:name]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  page.body.should have_content("Email")
  fill_in "Email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  find_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  visit root_path
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
  save_and_open_page
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  click_link "My Account"
  fill_in "user_name", :with => "newname"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit "/users"
  #save_and_open_page
  #a =   users_path
end

### THEN ###
Then /^I should be signed in$/ do
  page.body.should have_content @visitor[:email]
  page.body.should have_content "Log Out"
  page.body.should_not have_content "Sign up"
  page.body.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.body.should have_content "Sign up"
  page.body.should have_content "Sign in"
  page.body.should_not have_content "Sign out"
end


Then /^I see a successful sign in message$/ do
  #save_and_open_page
  #flash[:success].should =~  "Signed in successfully."
  page.body.should have_content "Log Out"
end

Then /^I should see a successful sign up message$/ do
  @user[:email].should eq(@visitor[:email])
  page.body.should have_content "Welcome!"
end

Then /^I should see an invalid email message$/ do
  page.body.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.body.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.body.should have_content "Password confirmation doesn't match Password"
end

Then /^I should see a mismatched password message$/ do
  page.body.should have_content "Password confirmation doesn't match Password"
end

Then /^I should see my name$/ do
  create_user
  page.body.should have_content @user[:email]
end


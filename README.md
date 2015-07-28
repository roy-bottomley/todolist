# Todolist using Rails4 & AngularJS

This is small program which implements a todo list management application to demonstrate Rails3 and Angular JS integration. All operations are performed on the client with the tasks and tasklists using CRUD operations to synchronize with the server over a  RESTful API.

the application is up and running [on heroku](http://rb-rails-angular-todo.herokuapp.com/)

## Installation

The application uses cdn's for its resources. You can just 
`git clone`
`bundle install'
`rake db:create`
`rake db:migrate`
and you should be up and running

## Usage

There is a normal devise log on page with password recovery to get into the application. 

Once in there is an interface to Yahoo weather at the top of the page as interface to an external API was part of the brief. It will start up with weather at your location, simply type in a new location and click change to see the weather elsewhere.   

The users tasklists are displayed your can
1. create a new tasklist by entering a name in the input field and clicking add task list
2. edit a tasklist by clicking edit alongside the tasklist name
3. delete a tasklist by clicking edit alongside the tasklist name
4. select a tasklist by clicking on the tasklist name.

Once a tasklist is selected its tasks are displayed. With task you can
1. create a new task by entering a description in the input field and clicking add task 
2. edit a task by clicking edit alongside the task description
3. delete a task by clicking edit alongside the task description
4. complete a tasklist by clicking on the checkbox to the left of the task description.
5. change the task due date by clicking on the date above the task description

## Structure

There are 3 rails models
1. A user which has_many task_lists
2. A task_list which has_many tasks and belongs_to a user
3. A task which belongs_to a task_list

The application renders a page containing a users id. Angular uses this id to request a list of tasklists for the user over the API and then displays the tasklists.

The are three Angular factories
1. A User which manages a list of tasklists
2. A Tasklist which manages a list of tasks
3. A service Interface used by the above to send/request data to the server.

             `
## Testing

1. Rspec unit tests for rails models ` bundle exec rspec spec`
2. Cucumber integration tests `bundle exec rake cucumber:all`


## Todo

1. include ui-router to easily display users and tasks on different pages
2. include ui-sortable to allow drag and drop operations to change task and tasklist priorities
3. implement a devise login over json


@toDoDemoApp.factory 'User', [  'serverInterface', 'Tasklist', (serverInterface, Tasklist) ->
  class User
    constructor: (@id) ->
      # server address for tasklists
      @tasklists = []
      @serverInterface = new serverInterface('/api/task_lists/', @tasklists)
      @serverInterface.all(@id)

    create_task: (model) ->
      model.task_list_id = @id
      @serverInterface.create(model)

    delete_task: (model) ->
      @serverInterface.delete(model)

    update_task: (model) ->
      @serverInterface.update(model)

    show_tasklist: (model) ->
      new  Tasklist(model)

]
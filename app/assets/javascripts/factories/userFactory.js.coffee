@toDoDemoApp.factory 'User', [  'serverInterface', 'Tasklist', (serverInterface, Tasklist) ->
  class User
    constructor: (@id) ->
      # server address for tasklists
      @tasklists = []
      @serverInterface = new serverInterface('/api/task_lists/', @tasklists)
      @serverInterface.all(@id)

    create_tasklist: (model) ->
      model.task_list_id = @id
      @serverInterface.create(model)

    delete_tasklist: (model) ->
      @serverInterface.delete(model)

    update_tasklist: (model) ->
      model.name = model.newName
      model.editing = false
      @serverInterface.update(model)

    show_tasklist: (model) ->
      new  Tasklist(model)

    edit_tasklist: (model) ->
      model.newName = model.name
      model.editing = true
      console.log(model)

    cancel_edit_tasklist: (model) ->
      model.editing = false

]
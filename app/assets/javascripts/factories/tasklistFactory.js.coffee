@toDoDemoApp.factory 'Tasklist', [  'serverInterface',  (serverInterface) ->
  class Tasklist

    constructor: (tasklist) ->
      keywords = ['extended', 'included', 'initialize']
      for key, value of tasklist when key not in keywords
        @[key] = value

      @tasks = []
      @orderBy  = 'priority'
      @orderDesc = true

      @serverInterface = new serverInterface('/api/tasks/', @tasks)
      @serverInterface.all(tasklist.id).then () =>
        @updateCompleted()

    create_task: (model) ->
      model.task_list_id = @id
      @serverInterface.create(model)

    delete_task: (model) ->
      @serverInterface.delete(model)

    update_task: (model) ->
      updated_model = $.extend({}, model)
      updated_model.description = updated_model.newDescription if updated_model.newDescription?
      updated_model.priority = updated_model.newPriority if updated_model.newPriority?
      @serverInterface.update(updated_model).then (data) =>
        model.editing = false
        @updateCompleted()

    edit_task: (model) ->
      model.newDescription = model.description
      model.newPriority = model.priority
      model.editing = true

    cancel_edit_task: (model) ->
      model.newDescription = null
      model.editing = false

    setSortOrder: () ->
      @orderDesc =  @orderBy == 'priority'
      @tasks.sort= (a, b) ->
       return a.priority > b.priority

    updateCompleted: () ->
      @completed = 0
      for task in @tasks
        @completed  += 1 if task.completed

]

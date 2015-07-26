@toDoDemoApp.factory 'Tasklist', [  'serverInterface', (serverInterface) ->
  class Tasklist

    constructor: (tasklist) ->
      keywords = ['extended', 'included', 'initialize']
      for key, value of tasklist when key not in keywords
        @[key] = value

      @tasks = []
      @serverInterface = new serverInterface('/api/tasks/', @tasks)
      @serverInterface.all(tasklist.id)

    create_task: (model) ->
      model.task_list_id = @id
      @serverInterface.create(model)

    delete_task: (model) ->
      @serverInterface.delete(model)

    update_task: (model) ->
      console.log("updating")
      console.log(model)
      model.editing = false
      @serverInterface.update(model)


]
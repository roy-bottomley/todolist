@toDoDemoApp.factory 'taskFactory', [  'serverInterface', (serverInterface) ->
  class taskFactory extends serverInterface
    constructor: (@tasklist) ->
      # server address for tasklists
      super('/api/tasks/', @tasklist.tasks)

    insertId= (task, tasklist) ->
      task.task_list_id = tasklist.id
      task

    create: (task) ->
      super(insertId(task,@tasklist))

]
@toDoDemoApp.factory 'taskListFactory', [  'serverInterface', (serverInterface) ->
  class taskListFactory extends serverInterface
    constructor: (list) ->
      # server address for tasklists
      super('/api/task_lists/', list)


]
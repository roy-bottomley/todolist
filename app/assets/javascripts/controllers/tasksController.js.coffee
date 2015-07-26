@toDoDemoApp.controller('tasksController', [ '$scope',   ($scope) ->
  $scope.sortMethod = 'priority'
  $scope.sortDirection = true


  $scope.create= () ->
    $scope.currentTaskList.create_task({description: $scope.newTaskDescription}).then (result) =>
      $scope.newTaskDescription = ''

  $scope.delete= (task) ->
    if confirm "Are you sure you want to remove the task '#{task.description}'?"
      $scope.currentTaskList.delete_task(task)

  $scope.update= (task) ->
    $scope.currentTaskList.update_task(task)

  $scope.edit= (task) ->
    $scope.user.edit_tasklist(task)

  $scope.cancel= (task) ->
    $scope.user.cancel_edit_tasklist(task)

])
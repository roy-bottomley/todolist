@toDoDemoApp.controller('tasklistsController', [ '$scope', '$timeout',($scope, $timeout) ->

  $scope.create= () ->
    $scope.user.create_tasklist({name: $scope.newTaskName}).then (result) ->
      $scope.newTaskDescription = ''

  $scope.delete= (taskList) ->
    if confirm "Are you sure you want to remove the tasklist #{taskList.name}?"
      $scope.user.delete_tasklist(taskList)

  $scope.update= (tasklist) ->
    $scope.user.update_tasklist(tasklist)

  $scope.edit= (taskList) ->
    $scope.user.edit_tasklist(taskList)

  $scope.cancel= (tasklist) ->
    $scope.user.cancel_edit_tasklist(tasklist)

  $scope.select= (taskList) =>
    $scope.currentTaskList = $scope.user.show_tasklist(taskList)

  $scope.createTask= () ->
    $scope.currentTaskList.create_task({description: $scope.newTaskDescription}).then (result) =>
      $scope.newTaskDescription = ''

  $scope.changeSort= () =>
    $scope.currentTaskList.setSortOrder()

])
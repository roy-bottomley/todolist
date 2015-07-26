@toDoDemoApp.controller('tasklistsController', [ '$scope',($scope) ->

  $scope.create= () ->
    $scope.user.create_tasklist({name: $scope.newTaskName}).then (result) ->
      $scope.newTaskDescription = ''

  $scope.delete= (taskList) ->
    if confirm "Are you sure you want to remove the tasklist #{taskList.name}?"
      $scope.user.delete_tasklist(taskList)

  $scope.updateTaskList= () ->
    $scope.user.update_tasklist($scope.editorTaskList).then (result) ->
      $scope.editorTaskList = null

  $scope.editTaskList= (taskList) ->
    $scope.editorTaskList = $.extend({}, taskList);

  $scope.cancelEdit= () ->
    $scope.editorTaskList = null

  $scope.select= (taskList) =>
    $scope.currentTaskList = $scope.user.show_tasklist(taskList)

])
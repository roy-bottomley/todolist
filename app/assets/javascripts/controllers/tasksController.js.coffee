@toDoDemoApp.controller('tasksController', [ '$scope',   ($scope) ->
  $scope.editor = null

  $scope.create= () ->
    $scope.currentTaskList.create_task({description: $scope.newTaskDescription}).then (result) =>
      $scope.newTaskDescription = ''

  $scope.delete= (task) ->
    if confirm "Are you sure you want to remove the task '#{task.description}'?"
      $scope.currentTaskList.delete_task(task)

  $scope.update= () ->
    $scope.currentTaskList.update_task($scope.editor).then (result) =>
      $scope.editor = null

  $scope.edit= (task) ->
    $scope.editor = $.extend({}, task);

  $scope.cancelEdit= () ->
    $scope.editor = null


])
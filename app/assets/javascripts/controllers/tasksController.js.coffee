@toDoDemoApp.controller('tasksController', [ '$scope',   ($scope) ->
  $scope.delete= () ->
    if confirm "Are you sure you want to remove the task '#{$scope.task.description}'?"
      $scope.currentTaskList.delete_task($scope.task)

  $scope.update= () ->
    $scope.currentTaskList.update_task($scope.task)

  $scope.edit= () ->
    $scope.currentTaskList.edit_task($scope.task)

  $scope.cancel= () ->
    $scope.currentTaskList.cancel_edit_task($scope.task)

])
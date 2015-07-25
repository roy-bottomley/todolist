@toDoDemoApp.controller('tasksController', [ '$scope',  'taskFactory', ($scope, appInitializer, taskFactory) ->
  $scope.editor = null

  $scope.create= () ->
    $scope.taskFactory.create({description: $scope.newTaskDescription}).then (result) =>
      $scope.newTaskDescription = ''

  $scope.delete= (task) ->
    if confirm "Are you sure you want to remove the task '#{task.description}'?"
      $scope.taskFactory.delete(task)

  $scope.update= () ->
    $scope.taskFactory.update($scope.editor).then (result) =>
      $scope.editor = null

  $scope.edit= (task) ->
    $scope.editor = $.extend({}, task);

  $scope.cancelEdit= () ->
    $scope.editor = null


])
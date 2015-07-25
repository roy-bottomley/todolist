@toDoDemoApp.controller('tasklistsController', [ '$scope', 'taskFactory',  ($scope, taskFactory) ->

  $scope.addTaskList= () ->
    $scope.taskListFactory.create({name: $scope.newTaskName}).then (result) =>
      $scope.newTaskName = ''

  $scope.deleteTaskList= (taskList) ->
    if confirm "Are you sure you want to remove this list?"
      $scope.taskListFactory.delete(taskList)

  $scope.updateTaskList= () ->
    $scope.taskListFactory.update($scope.editorTaskList).then (result) =>
      $scope.editorTaskList = null

  $scope.editTaskList= (taskList) ->
    $scope.editorTaskList = $.extend({}, taskList);

  $scope.cancelEdit= () ->
    $scope.editorTaskList = null

  $scope.select= (taskList) =>
    $scope.currentTaskList = taskList
    $scope.taskFactory = new taskFactory(taskList)

])
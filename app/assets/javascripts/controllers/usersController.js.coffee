@toDoDemoApp.controller('usersController', [ '$scope', 'appInitializer', 'taskListFactory', 'weatherFactory', ($scope, appInitializer, taskListFactory, weatherFactory) ->
  $scope.user =  appInitializer

  $scope.weather ={locations: []}
  $scope.weatherFactory = new weatherFactory($scope.weather)
  $scope.weatherFactory.show('home')

  $scope.taskListFactory = new taskListFactory($scope.user.task_lists)


])
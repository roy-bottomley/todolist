@toDoDemoApp.controller('usersController', [ '$scope', 'appInitializer',  'Weather', 'User', ($scope, appInitializer, Weather, User) ->

  $scope.user = new User(appInitializer.id)

  $scope.weather = new Weather()

  $scope.showWeather= () ->
    $scope.weather.show()

])
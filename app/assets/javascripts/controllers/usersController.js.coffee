@toDoDemoApp.controller('usersController', [ '$scope', 'appInitializer',  'Weather', 'User', '$sce',  ($scope, appInitializer, Weather, User, $sce) ->

  $scope.user = new User(appInitializer.id, appInitializer.email)

  $scope.weather = new Weather()

  $scope.showWeather= () ->
    $scope.weather.show()

  $scope.degreeSymbol= () ->
    $sce.trustAsHtml( String.fromCharCode(parseInt("00B0", 16)))
])
@toDoDemoApp = angular.module('toDoDemoApp', ['ngResource', 'templates'])

@toDoDemoApp.config ($httpProvider, $locationProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

  $locationProvider.html5Mode(true)




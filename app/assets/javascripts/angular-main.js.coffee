@toDoDemoApp = angular.module('toDoDemoApp', ['ngResource', 'templates', 'ui.date'])

@toDoDemoApp.config  ['$httpProvider', '$locationProvider', ($httpProvider, $locationProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

  $locationProvider.html5Mode(true)
]


@toDoDemoApp.run  [ '$location',  "$rootElement", ($location,  $rootElement) ->
#  must pass $location in to make the off click work
  $rootElement.off('click')
]

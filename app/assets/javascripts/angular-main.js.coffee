@toDoDemoApp = angular.module('toDoDemoApp', ['ngResource', 'templates', 'ui.date'])

@toDoDemoApp.config  ['$httpProvider', '$locationProvider', ($httpProvider, $locationProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

  $locationProvider.html5Mode(true)
]


@toDoDemoApp.run  [  "$rootElement", ( $rootElement) ->
  $rootElement.off('click')
]

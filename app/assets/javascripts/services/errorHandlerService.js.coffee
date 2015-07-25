@toDoDemoApp.service 'errorHandler', [ '$rootScope',
  class errorHandler
    constructor: (@$rootScope) ->

    process: (error) ->
      @$rootScope.$broadcast('flash', error)
]

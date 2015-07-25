@toDoDemoApp.directive( 'flash', [ '$timeout', ($timeout) ->
  return {
  restrict: 'E',
  scope: {
  },

  templateUrl: "flash.html",

  link: (scope, el, attrs) ->
    el.fadeOut(0)

    scope.doFlash= (msg) ->
      # stop and clear and previous message
      el.stop()
      $timeout.cancel( scope.timer ) if scope.timer

      # update the msg
      scope.messages = if $.isArray(msg) then msg else [msg]


      #fade the msg in, wait then fade it out
      el.fadeIn(500)
      timer = $timeout(
        () =>
          scope.timer = null
          el.fadeOut(2000)
        , 3000
      )

    # listen for events to flash
    scope.$on("flash", (e, msg) ->
      scope.doFlash(msg)
    )

  }
])

@toDoDemoApp.directive( 'taskDatepicker', [ () ->
  return {
  restrict: 'E',
  scope: {
    task: '='
    onChange: '&'
  },

  templateUrl: "taskDatePicker.html",

  link: (scope, el, attrs) ->
    scope.datepickerInput = el.find( "input" )

    scope.showDatepicker= () ->
      scope.datepickerInput.datepicker('show')
      return false

    scope.dateChanged= () ->
      scope.onChange()

  }
])
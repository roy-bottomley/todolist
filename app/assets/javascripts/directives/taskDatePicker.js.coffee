@toDoDemoApp.directive( 'taskDatepicker', [ () ->
  return {
  restrict: 'E',
  scope: {
    task: '='
    onChange: '&'
  },

  templateUrl: "taskDatePicker.html",

  link: (scope, el, attrs) ->

    scope.tdate =new Date(scope.task.due_date);

    scope.datepickerInput = el.find( "input" )

    scope.showDatepicker= () ->
      scope.datepickerInput.datepicker('show')
      return false

    scope.dateChanged= () ->
      scope.task.due_date = scope.tdate
      scope.onChange()

  }
])
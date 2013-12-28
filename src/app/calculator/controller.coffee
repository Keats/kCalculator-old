modules = []

calculatorCtrl = angular.module 'calculator.controller', modules

calculatorCtrl.controller 'CalculatorCtrl', ['$scope', ($scope) ->
  $scope.positiveIntegerRegex = /^[0-9]\d*$/

  # Defaults radio choices
  $scope.info =
    units: 'metric'
    gender: 'male'

  # This is the object the service will populate with data
  $scope.result =
    bmr: 0
    tdee: 0
    restDayCalories: 0
    workoutDayCalories: 0
    macros:
      proteins: 0
      proteinsCalories: 0
      rest:
        carbs: 0
        carbsCalories: 0
        fat: 0
        fatCalories: 0
      workout:
        carbs: 0
        carbsCalories: 0
        fat: 0
        fatCalories: 0

]

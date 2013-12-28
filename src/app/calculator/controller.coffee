modules = [
  'calculator.service'
]

calculatorCtrl = angular.module 'calculator.controller', modules

calculatorCtrl.controller 'CalculatorCtrl', ['$scope', 'calculatorService', ($scope, calculatorService) ->
  $scope.positiveIntegerRegex = /^[0-9]\d*$/
  $scope.activityLevels = calculatorService.activityLevels

  # Defaults option/radio choices
  $scope.info =
    units: 'metric'
    gender: 'male'
    activity: $scope.activityLevels[0]
    age: 25
    height: 178
    weight: 74

  $scope.diet =
    type: 'normal'
    calorieCycle: 'recomp'
    modifierRestDays: 0
    modifierWorkoutDays: 0
    protein: 3
    carbFatSplit: 'half'

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

  updateResults = ->
    if $scope.infoForm.$valid and $scope.dietForm.$valid
      leangains = calculatorService.calculateLeangains $scope.result.tdee, $scope.diet, $scope.info
      $scope.result.macros = leangains.macros
      $scope.result.restDayCalories = leangains.restDayCalories
      $scope.result.workoutDayCalories = leangains.workoutDayCalories

  $scope.$watchCollection 'info', ->
    if $scope.infoForm.$valid
      $scope.result.bmr = calculatorService.calculateBMR $scope.info
      $scope.result.tdee = calculatorService.calculateTDEE $scope.info.activity.value, $scope.result.bmr

      updateResults()

  $scope.$watchCollection 'diet', ->
    updateResults()

]

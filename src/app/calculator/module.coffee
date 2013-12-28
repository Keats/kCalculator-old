
modules = [
  'ui.router.state',
]

calculator = angular.module 'kcalculator.calculator', modules

calculator.config ['$stateProvider', ($stateProvider) ->
  $stateProvider.state 'calculator',
    url: '/'
    controller: 'CalculatorCtrl'
    templateUrl: 'calculator/index.html'
    data:
      pageTitle: 'Calculator'
]

calculator.controller 'CalculatorCtrl', ['$scope', ($scope) ->
]

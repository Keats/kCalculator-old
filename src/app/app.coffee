
modules = [
  'templates',

  'kcalculator.calculator',

  'ui.router.state'
]

appModule = angular.module('kcalculator', modules)

appModule.config(['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'
])

appModule.controller 'AppCtrl', ['$scope', '$location', ($scope, $location) ->
  $scope.$on '$stateChangeSuccess', (
    event, toState, toParams, fromState, fromParams
  ) ->
    if angular.isDefined(toState.data.pageTitle)
      $scope.pageTitle = toState.data.pageTitle
]
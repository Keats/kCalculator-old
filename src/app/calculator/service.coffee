
calculatorService = angular.module 'calculator.service', []

calculatorService.factory 'calculatorService', [() ->

  activityLevels = [
    value: 1.2
    label: 'Sedentary'
   ,
    value: 1.375
    label: 'Lightly active'
   ,
    value: 1.55
    label: 'Moderately active'
   ,
    value: 1.725
    label: 'Very active'
   ,
    value: 1.9
    label: 'Extra active'
  ]

  service = {}
  service.activityLevels = activityLevels


  service

]
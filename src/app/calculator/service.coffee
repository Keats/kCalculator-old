
calculatorService = angular.module 'calculator.service', []

calculatorService.factory 'calculatorService', [() ->

  service =  {}
  # Some utils to help us work with archaic measurements systems
  _convertLbsToKg = (weight) ->
    Math.round(weight * 0.45359237 * 100) / 100


  _convertInchesToCm = (height) ->
    Math.round(height / 0.393700787 * 100) / 100


  service.activityLevels = [
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

  # Mifflin-St Jeor formula
  # (http://en.wikipedia.org/wiki/Basal_metabolic_rate)
  service.calculateBMR = (info) ->
    if info.units is 'imperial'
      info.weight = _convertLbsToKg(info.weight)
      info.height = _convertInchesToCm(info.height)

    if info.gender is 'male'
      Math.round((10 * info.weight) + (6.25 * info.height) - (5 * info.age) + 5)
    else
      Math.round((10 * info.weight) + (6.25 * info.height) - (5 * info.age) - 161)


  service.calculateTDEE = (activity, bmr) ->
    Math.round(activity * bmr)


  service

]
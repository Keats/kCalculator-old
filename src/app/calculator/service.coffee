
calculatorService = angular.module 'calculator.service', []

calculatorService.factory 'calculatorService', [() ->

  # Some utils to help us work with archaic measurements systems
  _convertLbsToKg = (weight) ->
    Math.round(weight * 0.45359237 * 100) / 100


  _convertInchesToCm = (height) ->
    Math.round(height / 0.393700787 * 100) / 100

  # How many calories in 1g of a given macro
  _caloriesInMacro =
    proteins: 4
    carbs: 4
    fat: 9

  # Basic Leangains modifier, first number is rest days, second is workout days
  _leangainsClassicCycles =
    recomp: [-20 , 20]
    cut: [-30, -10]
    slowBulk: [-10, 30]

  # Contains macros for carbs, we can deduce macros for fat from it (100 - X)
  _leangainsMacros =
    half:
      rest: 50
      workout: 50
    quarter:
      rest: 25
      workout: 75
    fifth:
      rest: 20
      workout: 80


  service =  {}

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


  _calculateLeangainsCalories = (modifiers, tdee) ->
    (Math.round(tdee + (tdee * (modifier / 100))) for modifier in modifiers)


  # Proteins are easy to calculate since we have the g/kg value
  _calculateLeangainsProteins = (info, diet) ->
    if info.units is 'imperial'
      info.weight = _convertLbsToKg info.weight

    proteins = info.weight * diet.protein

    {
      proteins: proteins
      proteinsCalories: proteins * _caloriesInMacro.proteins
    }


  # Carbs and Fat are split after the proteins, calculating the % of the
  # remaining calories for each
  _calculateLeangainsMacro = (caloriesLeft, dayType, diet) ->
    result = {}

    carbsSplit = _leangainsMacros[diet.carbFatSplit]
    result.carbsCalories = Math.round((carbsSplit[dayType] / 100) * caloriesLeft)
    result.carbs = Math.round(result.carbsCalories / _caloriesInMacro.carbs)


    result.fatCalories = Math.round(((100 - carbsSplit[dayType]) / 100) * caloriesLeft)
    result.fat = Math.round(result.fatCalories / _caloriesInMacro.fat)

    result

  # Main part of the service, need to take into account the rest/workout split
  # and the carbs/fat split
  service.calculateLeangains = (tdee, diet, info) ->
    if diet.caloriesSplit is 'custom'
      modifiers =  [diet.modifierRestDays, diet.modifierWorkoutDays]
    else
      modifiers = _leangainsClassicCycles[diet.calorieCycle]

    proteins = _calculateLeangainsProteins info, diet
    [restCalories, workoutCalories] = _calculateLeangainsCalories modifiers, tdee

    restDay = _calculateLeangainsMacro(restCalories - proteins.proteinsCalories, 'rest', diet)
    workoutDay = _calculateLeangainsMacro(workoutCalories - proteins.proteinsCalories, 'workout', diet)

    {
      restDayCalories: restCalories
      workoutDayCalories: workoutCalories
      macros:
        proteins: proteins.proteins
        proteinsCalories: proteins.proteinsCalories
        rest: restDay
        workout: workoutDay
    }

  service

]
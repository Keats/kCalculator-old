describe 'Service: calculator', ->
  service = undefined

  beforeEach module('calculator.service')

  beforeEach inject((calculatorService) ->
    service = calculatorService
  )

  it 'should calculate BMR for a male', ->
    info =
      gender: 'male'
      weight: 70
      height: 178
      age: 25

    expectedBMR = 1693
    expect(service.calculateBMR(info)).to.equal expectedBMR

  it 'should calculate BMR for a female', ->
    info =
      gender: 'female'
      weight: 70
      height: 178
      age: 25

    expectedBMR = 1527
    expect(service.calculateBMR(info)).to.equal expectedBMR

  it 'should calculate TDEE for a given activity level',  ->
    activity = 1.2
    bmr = 1693
    expectedTDEE = 2032

    expect(service.calculateTDEE(activity, bmr)).to.equal expectedTDEE


  it "should calculate leangains data", ->
    tdee = 2032

    info =
      weight: 70
      units: 'metric'

    diet =
      calorieCycle: 'recomp'
      protein: 3
      carbFatSplit: 'half'

    expectedResult =
      restDayCalories: 1626
      workoutDayCalories: 2438
      macros:
        proteins: 210
        proteinsCalories: 840
        rest:
          carbs: 98
          carbsCalories: 393
          fat: 44
          fatCalories: 393
        workout:
          carbs: 200
          carbsCalories: 799
          fat: 89
          fatCalories: 799

    result = service.calculateLeangains(tdee, diet, info)
    expect(result).to.deep.equal expectedResult

  it "should calculate leangains data with custom calorie split", ->
    tdee = 2032

    info =
      weight: 70
      units: 'metric'

    diet =
      calorieCycle: 'custom'
      modifierRestDays: -20
      modifierWorkoutDays: 20
      protein: 3
      carbFatSplit: 'half'

    expectedResult =
      restDayCalories: 1626
      workoutDayCalories: 2438
      macros:
        proteins: 210
        proteinsCalories: 840
        rest:
          carbs: 98
          carbsCalories: 393
          fat: 44
          fatCalories: 393
        workout:
          carbs: 200
          carbsCalories: 799
          fat: 89
          fatCalories: 799

    result = service.calculateLeangains(tdee, diet, info)
    expect(result).to.deep.equal expectedResult

  it "should calculate leangains data with carbs/fat split", ->
    tdee = 2032

    info =
      weight: 70
      units: 'metric'

    diet =
      calorieCycle: 'recomp'
      protein: 3
      carbFatSplit: 'quarter'

    expectedResult =
      restDayCalories: 1626
      workoutDayCalories: 2438
      macros:
        proteins: 210
        proteinsCalories: 840
        rest:
          carbs: 49
          carbsCalories: 197
          fat: 66
          fatCalories: 590
        workout:
          carbs: 300
          carbsCalories: 1199
          fat: 44
          fatCalories: 400

    result = service.calculateLeangains(tdee, diet, info)
    expect(result).to.deep.equal expectedResult

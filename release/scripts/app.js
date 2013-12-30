/**
 * kCalculator - v0.1.0 - 2013-12-30
 * By Vincent Prouillet
 */
(function(){var a,b;b=["templates","kcalculator.calculator","ui.router.state"],a=angular.module("kcalculator",b),a.config(["$stateProvider","$urlRouterProvider",function(a,b){return b.otherwise("/")}]),a.controller("AppCtrl",["$scope","$location",function(a){return a.$on("$stateChangeSuccess",function(b,c){return angular.isDefined(c.data.pageTitle)?a.pageTitle=c.data.pageTitle:void 0})}])}).call(this),function(){var a,b;b=["calculator.service"],a=angular.module("calculator.controller",b),a.controller("CalculatorCtrl",["$scope","calculatorService",function(a,b){var c,d;return a.positiveIntegerRegex=/^[0-9]\d*$/,a.integerRegex=/^-?[0-9]\d*$/,a.activityLevels=b.activityLevels,a.info={units:"metric",gender:"male",activity:a.activityLevels[0]},a.diet={type:"normal",calorieCycle:"recomp",modifierRestDays:0,modifierWorkoutDays:0,protein:3,carbFatSplit:"half"},a.result={bmr:0,tdee:0,restDayCalories:0,workoutDayCalories:0,macros:{proteins:0,proteinsCalories:0,rest:{carbs:0,carbsCalories:0,fat:0,fatCalories:0},workout:{carbs:0,carbsCalories:0,fat:0,fatCalories:0}}},d=function(){var d;return a.infoForm.$valid&&a.dietForm.$valid?(c(),d=b.calculateLeangains(a.result.tdee,a.diet,a.info),a.result.macros=d.macros,a.result.restDayCalories=d.restDayCalories,a.result.workoutDayCalories=d.workoutDayCalories):void 0},c=function(){return a.result.bmr=b.calculateBMR(a.info),a.result.tdee=b.calculateTDEE(a.info.activity.value,a.result.bmr)},a.$watchCollection("info",function(){return d()}),a.$watchCollection("diet",function(){return d()})}])}.call(this),function(){var a,b;b=["calculator.controller","ui.router.state"],a=angular.module("kcalculator.calculator",b),a.config(["$stateProvider",function(a){return a.state("calculator",{url:"/",controller:"CalculatorCtrl",templateUrl:"calculator/index.html",data:{pageTitle:"Calculator"}})}])}.call(this),function(){var a;a=angular.module("calculator.service",[]),a.factory("calculatorService",[function(){var a,b,c,d,e,f,g,h,i;return g=function(a){return Math.round(100*.45359237*a)/100},f=function(a){return Math.round(100*(a/.393700787))/100},e={proteins:4,carbs:4,fat:9},h={recomp:[-20,20],cut:[-30,-10],slowBulk:[-10,30]},i={half:{rest:50,workout:50},quarter:{rest:25,workout:75},fifth:{rest:20,workout:80}},a={},a.activityLevels=[{value:1.2,label:"Sedentary"},{value:1.375,label:"Lightly active"},{value:1.55,label:"Moderately active"},{value:1.725,label:"Very active"},{value:1.9,label:"Extra active"}],a.calculateBMR=function(a){return"imperial"===a.units&&(a.weight=g(a.weight),a.height=f(a.height)),"male"===a.gender?Math.round(10*a.weight+6.25*a.height-5*a.age+5):Math.round(10*a.weight+6.25*a.height-5*a.age-161)},a.calculateTDEE=function(a,b){return Math.round(a*b)},b=function(a,b){var c,d,e,f;for(f=[],d=0,e=a.length;e>d;d++)c=a[d],f.push(Math.round(b+b*(c/100)));return f},d=function(a,b){var c;return"imperial"===a.units&&(a.weight=g(a.weight)),c=a.weight*b.protein,{proteins:c,proteinsCalories:c*e.proteins}},c=function(a,b,c){var d,f;return f={},d=i[c.carbFatSplit],f.carbsCalories=Math.round(d[b]/100*a),f.carbs=Math.round(f.carbsCalories/e.carbs),f.fatCalories=Math.round((100-d[b])/100*a),f.fat=Math.round(f.fatCalories/e.fat),f},a.calculateLeangains=function(a,e,f){var g,i,j,k,l,m,n;return g="custom"===e.calorieCycle?[e.modifierRestDays,e.modifierWorkoutDays]:h[e.calorieCycle],i=d(f,e),n=b(g,a),j=n[0],l=n[1],k=c(j-i.proteinsCalories,"rest",e),m=c(l-i.proteinsCalories,"workout",e),{restDayCalories:j,workoutDayCalories:l,macros:{proteins:i.proteins,proteinsCalories:i.proteinsCalories,rest:k,workout:m}}},a}])}.call(this),angular.module("templates",["calculator/index.html"]),angular.module("calculator/index.html",[]).run(["$templateCache",function(a){a.put("calculator/index.html",'<div class="info">\n  <h2>Info</h2>\n\n  <form novalidate name="infoForm">\n    <fieldset>\n      <legend>Unit</legend>\n\n      <input required id="metric" type="radio" ng-model="info.units" value="metric">\n      <label for="metric">Metric</label>\n\n      <input required id="imperial" type="radio" ng-model="info.units" value="imperial">\n      <label for="imperial">Imperial</label>\n    </fieldset>\n\n    <input required id="male" type="radio" ng-model="info.gender" value="male">\n    <label for="male">Male</label>\n\n    <input required id="female" type="radio" ng-model="info.gender" value="female">\n    <label for="female">Female</label>\n\n    <label for="age">Age</label>\n    <input required type="text" id="age" ng-model="info.age" ng-pattern="positiveIntegerRegex" />\n\n    <label for="height">\n      Height\n      <span ng-show="info.units == \'metric\'">in cm</span>\n      <span ng-show="info.units == \'imperial\'">in inches</span>\n    </label>\n    <input required type="text" id="height" ng-model="info.height" ng-pattern="positiveIntegerRegex" />\n\n    <label for="weight">\n      Weight\n      <span ng-show="info.units == \'metric\'">in kg</span>\n      <span ng-show="info.units == \'imperial\'">in lbs</span>\n    </label>\n    <input required type="text" id="weight" ng-model="info.weight" ng-pattern="positiveIntegerRegex" />\n\n    <label for="activity">Activity level</label>\n    <select required ng-model="info.activity" id ="activity" ng-options="a.label for a in activityLevels track by a.value">\n    </select>\n  </form>\n\n</div>\n\n<div class="diet">\n  <h2>Diet</h2>\n  <form novalidate name="dietForm">\n\n    <label for="calorieCycle">Rest / Workout split</label>\n    <select id ="calorieCycle" ng-model="diet.calorieCycle">\n      <option value="recomp">Sandard recomp (-20 / +20)</option>\n      <option value="cut">Cut (-30 / -10)</option>\n      <option value="slowBulk">Slow bulk (-10 / +30)</option>\n      <option value="custom">Custom</option>\n     </select>\n\n    <div ng-show="diet.calorieCycle == \'custom\'">\n      <label for="modifierRestDays">Rest day (% over/under TDEE)</label>\n      <input required type="text" id="modifierRestDays" ng-model="diet.modifierRestDays" ng-pattern="integerRegex" />\n\n\n      <label for="modifierWorkoutDays">Workout day (% over/under TDEE)</label>\n      <input required type="text" id="modifierWorkoutDays" ng-model="diet.modifierWorkoutDays" ng-pattern="integerRegex" />\n    </div>\n\n    <label for="protein">Protein (g/kg bodyweight)</label>\n    <input required type="text" id="protein" ng-model="diet.protein" />\n\n    <label for="carbFatSplit">Carbs / Fat split (Rest / Workout)</label>\n    <select id ="carbFatSplit" ng-model="diet.carbFatSplit">\n      <option value="half">50/50 - 50/50</option>\n      <option value="quarter">25/75 - 75/25</option>\n      <option value="fifth">20/80 - 80/20</option>\n    </select>\n\n  </form>\n</div>\n\n<div class="result">\n  <h2>Result</h2>\n\n  <table class="calories">\n    <tbody>\n      <tr>\n        <td><strong>BMR</strong></td>\n        <td>\n          {{ result.bmr }} kcal\n        </td>\n      </tr>\n      <tr>\n        <td><strong>TDEE</strong></td>\n        <td>\n          {{ result.tdee }} kcal\n        </td>\n      </tr>\n      <tr>\n        <td><strong>Rest day</strong></td>\n        <td>{{ result.restDayCalories }} kcal</td>\n      </tr>\n      <tr>\n        <td><strong>Workout day</strong></td>\n        <td>{{ result.workoutDayCalories }} kcal</td>\n      </tr>\n    </tbody>\n  </table>\n\n  <table class="macros">\n    <tbody>\n\n    <tr>\n      <th></th>\n      <th>Rest</th>\n      <th>Workout</th>\n    </tr>\n\n    <tr>\n      <td><strong>Fat</strong></td>\n      <td>{{ result.macros.rest.fat }}g ({{ result.macros.rest.fatCalories }} kcal)</td>\n      <td>{{ result.macros.workout.fat }}g ({{ result.macros.workout.fatCalories }} kcal)</td>\n    </tr>\n\n    <tr>\n      <td><strong>Carbs</strong></td>\n      <td>{{ result.macros.rest.carbs }}g ({{ result.macros.rest.carbsCalories }} kcal)</td>\n      <td>{{ result.macros.workout.carbs }}g ({{ result.macros.workout.carbsCalories }} kcal)</td>\n    </tr>\n\n    <tr>\n      <td><strong>Proteins</strong></td>\n      <td>{{ result.macros.proteins }}g  ({{ result.macros.proteinsCalories }} kcal)</td>\n      <td>{{ result.macros.proteins }}g ({{ result.macros.proteinsCalories }} kcal)</td>\n    </tr>\n\n    </tbody>\n  </table>\n\n</div>')}]);
describe 'AppCtrl', ->

  beforeEach module("kcalculator")

  it "should have a dummy test", inject(->
    chai.expect(true).to.be.true
  )

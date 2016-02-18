Vue.directive "dom-events", require("../src/domEvents.coffee")
comp = loadComp
  template: "<div><div v-dom-events v-if='visible' @enter='onEnter' @leave='onLeave'></div></div>"
  data: ->
    enter: null
    leave: null
    visible: false
  methods:
    onEnter: ->
      @enter?()
    onLeave: -> @leave?()

describe "domEvents", ->
  it "should call enter on enter", (done) ->
    comp.enter = chai.spy()
    comp.visible = true
    setTimeout (->
      comp.enter.should.have.been.called.once
      done()
      ),100
  it "should call leave on leave", (done) ->
    comp.leave = chai.spy()
    comp.visible = false
    setTimeout (->
      comp.leave.should.have.been.called.once
      done()
      ),100

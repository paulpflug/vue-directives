Vue.directive "on-resize", require("../src/onResize.coffee")
comp = loadComp
  template: "<div v-on-resize='onResize'><div v-el:child></div></div>"
  data: ->
    resize: null
  methods:
    onResize: ->
      @resize?()

describe "onResize", ->
  it 'should call cb on window resize'
  it "should call cb on element size change", (done) ->
    comp.resize = chai.spy()
    comp.$el.setAttribute("style", "height:200px;width:200px")
    setTimeout (->
      comp.resize.should.have.been.called.once
      comp.$el.removeAttribute("style")
      setTimeout (->
        comp.resize.should.have.been.called.twice
        done()
        ),100
      ),100
  it "should call cb on element when an larger inner element is added", (done) ->
    comp.resize = chai.spy()
    comp.$els.child.setAttribute "style", "height:200px;width:300px"
    setTimeout (->
      comp.resize.should.have.been.called.once
      comp.$els.child.removeAttribute("style")
      setTimeout (->
        comp.resize.should.have.been.called.twice
        done()
        ),100
      ),100

# out: ../onResize.js
resizeRunning = false
allResizeCbs = []
resizeHandler = ->
  unless resizeRunning
    resizeRunning = true
    if window.requestAnimationFrame
      window.requestAnimationFrame callResizeCbs
    else
      setTimeout callResizeCbs, 66
callResizeCbs = (e) ->
  for cb in allResizeCbs
    cb(e)
  resizeRunning = false
window.addEventListener "resize", resizeHandler
observer = new MutationObserver resizeHandler
observer.observe document.body,
  attributes: true
  childList: true
  characterData: true
  subtree: true

module.exports =
  acceptStatement: true
  disposable: null
  oldheight: null
  oldwidth: null
  bind: ->
    @oldheight = @el.offsetHeight
    @oldwidth = @el.offsetWidth
  update: (fn) ->
    @disposable?()
    cbwrapper = (e) =>
      if @oldheight != @el.offsetHeight or @oldwidth != @el.offsetWidth
        if (@oldheight != 0 and @oldwidth != 0) or
           (@el.offsetHeight != 0 and @el.offsetWidth != 0)
          fn(e)
        @oldheight = @el.offsetHeight
        @oldwidth = @el.offsetWidth
    allResizeCbs.push cbwrapper
    @disposable = ->
      index = allResizeCbs.indexOf cbwrapper
      if index > -1
        allResizeCbs.splice index,1
  unbind: ->
    @disposable?()

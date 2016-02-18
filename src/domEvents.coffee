# out: ../domEvents.js

createEvent = (event, params) ->
  ce = window.CustomEvent
  unless ce?
    ce = (event, opt) ->
      opt = opt || bubbles: false, cancelable: false, detail: undefined
      evt = document.createEvent('CustomEvent')
      evt.initCustomEvent(event, opt.bubbles, opt.cancelable, opt.detail)
      return evt
    ce.prototype = window.Event.prototype
  return new ce(event,params)

module.exports =
  priority: 600
  bind: -> @el.dispatchEvent createEvent "enter"
  unbind: -> @el.dispatchEvent createEvent "leave"

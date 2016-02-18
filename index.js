install = function(Vue) {
  Vue.use(require("./resize.js"))
}
if (module.exports != null){
  module.exports = install
} else if (window.Vue != null){
  window.Vue.use(install)
} else {
  window.vueDirectives = install
}

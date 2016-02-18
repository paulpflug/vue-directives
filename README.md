# vue-directives

A collection of directives for vue.  

## Policy

all sorts of directives can be submitted. There will be no removes because of deprecation. If the API of a directive changes, the name has to change.

## Install

```sh
npm install --save-dev vue-directives

```
## Usage
```coffee
Vue.directive "on-resize", require("vue-directives/onResize")
Vue.directive "dom-events", require("vue-directives/domEvents")
```
## List of directives
| Name | argument |  description |
| ---: | ----  |  ------- |
| onResize | expression | evaluates the expression once the element resizes|
| domEvents | - | emits `enter`, `leave` event when element enters/leaves the dom|


## Detailed usage
### domEvents
```html
<div v-dom-events @enter="doSomething" @leave="doAnotherThing"></div>
```

## Develop
Clone rep
```
npm install
```
Available scripts:
```
npm run build # compiles coffee-script in src/
npm run test # runs a single-run karma in chrome and firefox
npm run watch # runs karma in chrome (uses src/*.coffee files direclty, no need for build)

# to run only single tests:
karma start --browsers Chrome --auto-watch --reporters spec --files ['test/onClick.coffee']
```

## License
Copyright (c) 2015 Paul Pflugradt
Licensed under the MIT license.

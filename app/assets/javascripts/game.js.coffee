# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

roundTo2DecimalPlaces = (n) ->
  Math.round(n * 100) / 100
calcExpectedRollPercents = (totalRolls) ->
  rollPercentages = [
    2.7777
    5.5555
    8.3333
    11.1111
    13.8888
    16.6666
    13.8888
    11.1111
    8.3333
    5.5555
    2.7777
  ]
  expectedPercentages = new Array(11)
  i = 0

  while i < rollPercentages.length
    expectedPercentages[i] = roundTo2DecimalPlaces(rollPercentages[i] * totalRolls)
    i++
  expectedPercentages


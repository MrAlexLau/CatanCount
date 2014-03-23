// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap
//= require_tree .

function drawChart(actuals, expecteds) {
  return new Highcharts.Chart({
    chart: {
        type: 'column',
        renderTo: 'chart'
    },
    title: {
        text: 'Dice Rolls: Actual vs Expected'
    },
    xAxis: {
        categories: ['2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']
    },
    yAxis: {
        title: {
            text: 'Rolls'
        }
    },
    colors: [
       '#2f7ed8', 
       '#a6c96a'
    ],
    plotOptions: {
        column: {
            dataLabels: {
                enabled: true
            },
            enableMouseTracking: false
        }
    },
    series: [{
        name: 'Actual',
        data: actuals,
        backgroundColor: '#2DD62D'
    }, {
        name: 'Expected',
        data: expecteds
    }]
  });
}

function roundTo2DecimalPlaces(n) {
    return Math.round(n * 100) / 100;
}

function calcExpectedRollPercents(totalRolls) {
    var rollPercentages = [2.7777, 5.5555, 8.3333, 11.1111, 13.8888, 16.6666, 13.8888, 11.1111, 8.3333, 5.5555, 2.7777],
        expectedPercentages = new Array(11);

    for (var i = 0; i < rollPercentages.length; i++) {
        expectedPercentages[i] = roundTo2DecimalPlaces((rollPercentages[i] / 100) * totalRolls);
    }
    return expectedPercentages;
}

function getArrayIndex(n) {
  return n - 2;
}

function getTotalRolls(arr) {
  var sum = 0;
  for(var i = 0; i < arr.length; i++){
    sum += arr[i];
  }
  return sum;
}

$( document ).ready( function() {
  $('.dice-roll').click(function(e){
    var rollValue = parseInt($(this).data('value'));

    actualSeries[getArrayIndex(rollValue)]++;
    expectedSeries = calcExpectedRollPercents(getTotalRolls(actualSeries));

    chart.series[0].setData(actualSeries, false);
    chart.series[1].setData(expectedSeries, false);
    chart.redraw();
  })
})
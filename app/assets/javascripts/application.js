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
//= require_tree .

function drawChart(actuals, expecteds) {
  $('#chart').highcharts({
    chart: {
        type: 'column'
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
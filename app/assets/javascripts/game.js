
function drawChart(actuals, expecteds) {
  if (getTotalRolls(actuals) < 1) { return null; }
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

function updateRollsHistory(rollsArr, newestRoll) {
  var total = getTotalRolls(rollsArr),
      rollStr = 'rolls',
      rollHistoryStr = '';

  if (total === 1) { rollStr = 'roll'; }
  $('#recent-rolls-header').html("" + total + " " + rollStr + " for this game:");

  $('#rolls-history').html($('#rolls-history').html().trim());
  if (total > 1) {
    $('#rolls-history').append(', ' + newestRoll);
  }
  else {
    $('#rolls-history').append(newestRoll);
  }
}

$( document ).ready( function() {
  $('.dice-roll').click(function(e){
    var rollValue = parseInt($(this).data('value'));

    actualSeries[getArrayIndex(rollValue)]++;
    expectedSeries = calcExpectedRollPercents(getTotalRolls(actualSeries));

    if (chart === null) {
      chart = drawChart(
        actualSeries,
        expectedSeries
      );
    }
    chart.series[0].setData(actualSeries, false);
    chart.series[1].setData(expectedSeries, false);
    chart.redraw();

    updateRollsHistory(actualSeries, rollValue);

    $('#enter-dice-roll').hide();
    $('#recent-rolls-div').show();
  });

  $('#undo-last-roll').click(function(e){
    var allRolls = $('#rolls-history').html(),
        delimiter = ',',
        lastRollValue = -1;

    if (allRolls.lastIndexOf(delimiter) === -1){
      lastRollValue = allRolls.trim();
    }
    else {
      lastRollValue = allRolls.substring(allRolls.lastIndexOf(delimiter) + delimiter.length).trim();
    }

    $('#rolls-history').html(allRolls.substring(0, allRolls.lastIndexOf(',')));

    actualSeries[getArrayIndex(lastRollValue)]--;
    expectedSeries = calcExpectedRollPercents(getTotalRolls(actualSeries));

    if (chart === null) {
      chart = drawChart(
        actualSeries,
        expectedSeries
      );
    }
    chart.series[0].setData(actualSeries, false);
    chart.series[1].setData(expectedSeries, false);
    chart.redraw();


    var total = getTotalRolls(actualSeries);
    if (total < 1){
      $('#recent-rolls-div').hide();
    }
  });
});
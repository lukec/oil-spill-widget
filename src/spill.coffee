$div = $("#spillWidget")
$div.html '<link rel="stylesheet" type="text/css" href="http://spill-widget.openwe.st/css/counter.css" /><div id="spillCounter" class="flip-counter"></div>'
opts =
    per_day:                $div.data('litres-per-day')         or 1000
    start_date:             $div.data('start-date')             or "2013-01-01"
    initial_litres_spilled: $div.data('initial-litres-spilled') or 0

litres_of_oil_spilled_so_far = ->
    start_date = moment(opts.start_date, "YYYY-MM-DD")
    now = moment()
    i = start_date
    rate = opts.per_day
    litres = opts.initial_litres_spilled
    while i < now
        i.add 'days', 1
        litres += rate
    litres += now.hours() * (rate / 24)
    litres += now.minutes() * (rate / 24 / 60 )
    litres += now.seconds() * (rate / 24 / 60 / 60 )
    litres = parseInt litres
    return litres

$ ->
    litres_per_second = opts.per_day / 24 / 60 / 60
    seconds_per_litre = 1 / litres_per_second
    pace = seconds_per_litre * 1000
    counter = new flipCounter "spillCounter"
        value: litres_of_oil_spilled_so_far()
        pace: parseInt(pace)


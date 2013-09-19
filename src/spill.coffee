$div = $("#spillWidget")
$div.html '<link rel="stylesheet" type="text/css" href="http://spill-widget.openwe.st/css/counter.css" /><div id="spillCounter" class="flip-counter"></div>'
opts =
    per_day:                $div.data('litres-per-day')         or 3179.75
    start_date:             $div.data('start-date')             or "2013-09-19"
    initial_litres_spilled: $div.data('initial-litres-spilled') or 1528996.71

litres_of_oil_spilled_so_far = ->
    start_date = moment(opts.start_date, "YYYY-MM-DD")
    i = start_date
    rate = opts.per_day
    litres = opts.initial_litres_spilled
    today_start = moment().startOf('day')
    while i < today_start
        i.add 'days', 1
        litres += rate
    now = moment()
    litres += now.hours() * (rate / 24)
    litres += now.minutes() * (rate / 24 / 60 )
    litres += now.seconds() * (rate / 24 / 60 / 60 )
    return litres

$ ->
    litres_per_second = opts.per_day / 24 / 60 / 60
    seconds_per_litre = 1 / litres_per_second
    
    counter = new flipCounter "spillCounter",
        value: litres_of_oil_spilled_so_far()
        pace: seconds_per_litre * 10 # centiseconds
        inc: .01


litres_of_oil_spilled_so_far = (opts) ->
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
    console.log "#{now.format()}: #{litres} litres"
    return parseInt litres

update_widget = ->
    $div = $("#spillWidget")
    opts =
        per_day: $div.data('litres-per-day') or 1000
        start_date: $div.data('start-date')  or "2013-01-01"
        initial_litres_spilled: $div.data('initial-litres-spilled') or 0
    $div.html "#{litres_of_oil_spilled_so_far(opts)}"

update_widget()
setInterval update_widget, 1000


_addon.name = 'Camp NM'
_addon.author = 'Cliff'
_addon.version = '1.0.0'
_addon.commands = {'camp','cp'}

require('logger')

local reversed = false

function walk()
    if not reversed then
        windower.send_command("input //fsd g 1")
    else
        windower.send_command("input //fsd g 1 r")
    end
    reversed = not reversed
    coroutine.sleep(20)
end

function main()
    windower.send_command("input //lz start")
    coroutine.sleep(60)
    windower.send_command("input //lz stop")
    coroutine.sleep(1)
    walk()
    windower.send_command("input //lz start")
    coroutine.sleep(30)
    windower.send_command("input //lz stop")
    coroutine.sleep(1)
    walk()
    coroutine.sleep(12*60)
    main()
end

windower.register_event('addon command', function(command, ...)
    if T{"go","g"}:contains(command) then
        log('Enabled!!')
        main()
    elseif T{"stop","s"}:contains(command) then
        windower.send_command("input //fsd s")
    elseif command =="flag" then
    else
        log('enabled: '..tostring(enabled))
    end
end)

windower.register_event('load', function()
    log('===========loaded===========')
    main()
end)

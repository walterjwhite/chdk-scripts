--[[
@title Intervalometer
--]]

-- time in milliseconds between frames
t=5000
focused_property=18

--
start_time=get_tick_count()
frame=0

-- sleep precisely the time between the next frame and return whether a button was pressed
function next_frame_sleep ()
   local sleep_time = (start_time + frame * t) - get_tick_count()
   if sleep_time < 1 then
      sleep_time = 1
   end
   wait_click(sleep_time)

   frame = frame + 1
   return not is_key("no_key")
end

-- Prefocus to eliminate the orange light and the slow auto focus
function prefocus()
  local focused = false
  local try = 1
  while not focused and try <= 5 do
    print("Pre-focus attempt " .. try)
    press("shoot_half")
    sleep(2000)
    if get_prop(focused_property) > 0 then
      focused = true
      set_aflock(1)
    end
  
    release("shoot_half")
    sleep(500)
    try = try + 1
  end
end

prefocus()
set_lcd_display(0)

while true do
	shoot()
    if next_frame_sleep() then
      set_lcd_display(1)
      print("Button pressed - exiting")
      
      break
    end
end


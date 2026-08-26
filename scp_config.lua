-- Ship Control Protocol v2.1
-- Developer: MCNaOtlichno_YT
-- No AI-generated code used


-- Configure peripherals and other values in this file.
navigation_table = peripheral.wrap("navigation_table_0")


-- These are for turns.
-- For turns you need to use two propellers on your ship sides.
-- You power them like this:
--                                      [     Cogwheel      ] - [To propellers]
-- [motor(256 RPM)]-[Shaft]-[Gearshift]-[Analog Transmission]
--                          [Red.Relay] [    Red. Relay     ] (relays below Gearshift and Analog Transmission)
--                               /\              /\
--                     turn_reverse              turn_speed
-- And make sure that propellers push air in different directions, one forward and one backward.
turn_speed = peripheral.wrap("redstone_relay_2")
turn_reverse = peripheral.wrap("redstone_relay_3")
default_turn = "left" -- Where your ship turns when gearshift is unpowered. Options are "left" and "right", both in lower case.


-- This is for your main propeller that pushes your ship forward.
-- Connection is the same like with turns. Make sure that it moves ship forward when gearshift is not powered.
main_speed = peripheral.wrap("redstone_relay_0")
main_reverse = peripheral.wrap("redstone_relay_1")


-- Do not touch this. If your ship calculates coordinates and moves wrong way then change this 0 to 1, 2 or 3.
heading_offset = 0
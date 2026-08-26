-- Ship Control Protocol v2.1
-- Developer: MCNaOtlichno_YT
-- No AI-generated code used
 
 
config = require('scp_config')
 
	
function formatAngle(angle)
    if angle > math.pi then
        angle = angle - 2 * math.pi
    elseif angle < -math.pi then
        angle = angle + 2 * math.pi
    end
    return angle
end
 
 
function getHeading()
    heading = math.pi - navigation_table.getHeadingRad() + 0.5 * math.pi * heading_offset
    return formatAngle(heading)
end
 
 
function getShipPosition()
    position = sublevel.getLogicalPose().position
    return position.x, position.y, position.z
end
 
 
function setMainSpeed(speed)
    main_speed.setAnalogOutput("top", 15 - speed)
end
 
 
function setTurnSpeed(speed)
    turn_speed.setAnalogOutput("top", 15 - speed)
end
 
 
function findHeadingToTarget(target_x, target_z)
    ship_x, ship_y, ship_z = getShipPosition()
    d_x = target_x - ship_x
    d_z = target_z - ship_z
    d_xz = math.sqrt(d_x * d_x + d_z * d_z)
    angle = math.acos(math.abs(d_x) / d_xz)
    if d_x <= 0 and d_z <= 0 then
        heading = angle
    elseif d_x <= 0 and d_z > 0 then
        heading = -angle
    elseif d_x > 0 and d_z <= 0 then
        heading = math.pi - angle
    elseif d_x > 0 and d_z > 0 then
        heading = angle - math.pi
    end
    return heading
end
 
 
function flyToCoords(target_x, target_z)
    setMainSpeed(0)
    setTurnSpeed(0)
    repeat
        ship_x, ship_y, ship_z = getShipPosition()
        d_xz = math.sqrt((ship_x - target_x) * (ship_x - target_x) + (ship_z - target_z) * (ship_z - target_z))
        target_heading = findHeadingToTarget(target_x, target_z)
        heading = getHeading()
        d_angle = formatAngle(target_heading - heading)
        if math.abs(d_angle) < math.pi / 18 then
            -- Heading error is less than 5 degrees -> we can start main propeller.
            if d_xz > 100 then
                setMainSpeed(15)
            elseif d_xz > 50 then
                setMainSpeed(7)
            elseif d_xz > 25 then
                setMainSpeed(3)
            else
                setMainSpeed(1)
            end
        else
            -- Stop propeller
            setMainSpeed(0)
        end
        if d_angle < 0 then -- prepare to turn left
            if default_turn == "right" then
                turn_reverse.setAnalogOutput("top", 15)
            else
                turn_reverse.setAnalogOutput("top", 0)
            end
        else -- prepare to turn right
            if default_turn == "left" then
                turn_reverse.setAnalogOutput("top", 15)
            else
                turn_reverse.setAnalogOutput("top", 0)
            end
        end
        if math.abs(d_angle) > math.pi / 6 then
            setTurnSpeed(15)
        elseif math.abs(d_angle) > math.pi / 12 then
            setTurnSpeed(7)
        elseif math.abs(d_angle) > math.pi / 24 then
            setTurnSpeed(3)
        elseif math.abs(d_angle) > 0 then
            setTurnSpeed(2)
        end
  		sleep(0.5)
    until d_xz < 20
    setMainSpeed(0)
    setTurnSpeed(0) 
end
 
 
function wtf()
    o = sublevel.getLogicalPose().orientation
    a0 = o.a
    a1 = o.v.x
    a2 = o.v.y
    a3 = o.v.z
    b1 = 2 * (a0 * a3 + a1 * a2)
    b2 = a0 * a0 + a1 * a1 - a2 * a2 - a3 * a3
    return math.asin(2 * a0 * a2) * 57.3
end
 
 
return {format_angle = format_angle,
        getHeading = getHeading,
        getShipPosition = getShipPosition,
        findHeadingToTarget = findHeadingToTarget,
        setTurnSpeed = setTurnSpeed,
        setMainSpeed = setMainSpeed,
        flyToCoords = flyToCoords}
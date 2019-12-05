' One handed clock.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-03-25
' fun challenge posted at LB 3/24
' What are the times that the two hands of clock make straight line?

' I think once an hour the minute hand is exactly 180 degrees past the hour hand
' oops! not quite ;-))

cx = 800 / 2 : cy = 600 / 2  'center of clock
times = ""                   'save one long armed times here
bkc = rgb(100, 255, 255)
color bkc, bkc
cls
color 1
locate 1, 5 : ?  "The One (long) Handed Clock Problem"
locate 25, 5 : ? "Times at which the hands of the clock form a straight line."
color 3
circle cx, cy, 210  filled
for secs = 0 to 3600 * 12     'get these to the sec

    '         360 degrees * fraction of circle hour hand makes to 12:00
    hourDeg = 360 * secs / (3600 * 12)
    '         360 degrees * fraction of circle minute hand makes to 12:00
    minDeg  = 360 * secs / 3600

    'digital time
    hrs = str(int(secs / 3600))
    if hrs = "0" then hrs = "12" else hrs = right("00" + hrs, 2)
    mins = right("00" + str(int(secs / 60) mod 60), 2)
    scs = right("00" + str(secs mod 60), 2)
    ctime = hrs + ":" + mins + ":" + scs

    ' End points of hour amd minute hands: convert angles
    ' to radians for Sin and Cos such that 12:00:00 = 0 radians
    ' so minus 90 because JB 0 degrees is due East.
    hx = cx + 100 * cos(rad(hourDeg - 90))
    hy = cy + 100 * sin(rad(hourDeg - 90))
    mx = cx + 140 * cos(rad(minDeg - 90))
    my = cy + 140 * sin(rad(minDeg - 90))
    'note: hour hand is 100 and minute hand is 140, sum = 240

    'the two arms form striaght line:
    'when the distance from two end points NEARLY
    'equals the sum of length of hands            <= .00005
    dist = ((hx - mx) ^ 2 + (hy - my) ^ 2) ^ .5

    'get the first one within our limit of .00005 for hour
    if abs(240 - dist) < .00002 then 'NEARLY straight line
        hours = left(ctime, 2)
        if hours <> left(lastHour, 2) then
            times = times + chr(10) + space(5) + ctime
            lastHour = ctime
            pF = 1
        end if
    end if

    'every (speeded up) 60 secs or pF =pauseFlag, display update 
    if secs mod 60 = 0 or pF then
        color rgb(0, 255, 200)
        circle cx, cy, 200 filled
        color rgb(200, 0, 0)
        for i = 1 to 12
            x = cx + 155 * cos(i * 2 * PI /12)
            y = cy + 155 * sin(i * 2 * PI /12)
            if i mod 3 = 0 then circle x, y, 12 filled else circle x, y, 8 filled
        next
        color 0, bkc
        locate 4, 5 : ? ctime
        locate 8, 1 : ? times
        color rgb(0, 100, 128)
        thickLine cx, cy, hx, hy, 4
        circle hx, hy, 10 filled
        thickLine cx, cy, mx, my, 4
        if pF then delay 1000
        pF = 0
        'showpage  '<<<< funny the hands don't stop at the right places with this
                   '     6:00:00 is the best bad example!!!
    end if
next
pause

sub thickLine(x1, y1, x2, y2, rThick)
  'x1, y1 is one endpoint of line
  'x2, y2 is the other endpoint of the line
  'rThick is the radius of the tiny circles that will be drawn 
  '   from one end point to the other to create the thick line
  'Yes, the line will then extend beyond the endpoints with circular ends.

  local length, stepx, stepy, dx, dy, i
  stepx = x2 - x1 : stepy = y2 - y1
  length = (stepx ^ 2 + stepy ^ 2) ^.5
  if length then
    dx = stepx / length : dy = stepy / length
    for i = 0 to length
      circle x1 + dx * i, y1 + dy * i, rThick filled
    next
  end if
end
rem Welcome to SmallBASIC

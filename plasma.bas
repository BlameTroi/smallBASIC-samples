'Star Maker on plasma.bas  SmallBASIC 0.12.6 [B+=MGA] 2016-06-04

'Thanks Andy Amaya for following code
sub filltri(x1, y1, x2, y2, x3, y3)
  local x, y, length, slope1, slope2, slope3
  'triangle coordinates must be ordered: where x1 < x2 < x3
  if x2 < x1 then x = x2 : y = y2 : x2 = x1 : y2 = y1 : x1 = x : y1 = y
  'swap x1, y1, with x3, y3
  if x3 < x1 then x = x3 : y = y3 : x3 = x1 : y3 = y1 : x1 = x : y1 = y
  'swap x2, y2 with x3, y3
  if x3 < x2 then x = x3 : y = y3 : x3 = x2 : y3 = y2 : x2 = x : y2 = y
  if x1 <> x3 then slope1 = (y3 - y1) / (x3 - x1)
  'draw the first half of the triangle
  length = x2 - x1
  if length <> 0 then
    slope2 = (y2 - y1) / (x2 - x1)
    for x = 0 to length
      line int(x + x1), int(x * slope1 + y1), int(x + x1), int(x * slope2 + y1)
    next
  end if
  'draw the second half of the triangle
  y = length * slope1 + y1 : length = x3 - x2
  if length <> 0 then
    slope3 = (y3 - y2) / (x3 - x2)
    for x = 0 To length
      line int(x + x2), int(x * slope1 + y), int(x + x2), int(x * slope3 + y2)
    next
  end if
  line x1, y1, x2, y2
  line x2, y2, x1, y1
  line x2, y2, x3, y3
  line x3, y3, x2, y2
  line x1, y1, x3, y3
  line x3, y3, x1, y1
end

sub Star(x, y, rInner, rOuter, nPoints, angleOffset, TFfill)
  ' x, y are same as for circle,
  ' rInner is center circle radius
  ' rOuter is the outer most point of star
  ' nPoints is the number of points,
  ' angleOffset = angle offset IN DEGREES, it will be converted to radians in sub
  ' this is to allow us to spin the polygon of n sides
  ' TFfill filled True or False (1 or 0)
  local p_angle, rad_angle_offset, x1, y1, x2, y2, x3, y3, i
  p_angle = rad(360 / nPoints)  :  rad_angle_offset = rad(angleOffset)
  x1 = x + rInner * cos(rad_angle_offset)
  y1 = y + rInner * sin(rad_angle_offset)
  for i = 0 to nPoints - 1
    x2 = x + rOuter * cos(i * p_angle + rad_angle_offset + .5 * p_angle)
    y2 = y + rOuter * sin(i * p_angle + rad_angle_offset + .5 * p_angle)
    x3 = x + rInner * cos((i + 1) * p_angle + rad_angle_offset)
    y3 = y + rInner * sin((i + 1) * p_angle + rad_angle_offset)
    if TFfill then
      filltri x1, y1, x2, y2, x3, y3
    else
      line x1, y1, x2, y2
      line x2, y2, x3, y3
    end if
    x1 = x3 : y1 = y3
  next
  if TFfill then circle x, y, rInner filled  
end

'demo
npoints = 3 
cx = xmax / 2 : cy = ymax / 2
const a=127
while npoints < 18
  cls
  b = rnd ^ 2 : c = rnd ^ 2 : d = rnd ^ 2
  for r = 1 to 100
    color RGB(a + a * sin(b * r), a + a * sin(c * r), a + a * sin(d * r))
    star cx, cy, r, r * 3.5, npoints, ang, 0
  next
  showpage
  delay 130
  npoints ++
  if npoints > 17 then npoints = 3
wend

'Mira.bas for SmallBASIC 0.12.8 [B+=MGA] update 2017-02-20

''update  Mira fractals from SmallBASIC
'' Martin Latter
'' Converted to SB from my old 1992 version in Archimedes BASIC
'' - SB and modern computers thankfully plot a bit faster.

'In most Mira all the interesting stuff happens immediately.

'This code will stay with one Mira until you press a key

randomize
xc = xmax/2
yc = ymax/2
dots = 10000 'for one round on Mira 
dim ca(int(dots/100))

while 1
  'set round
  a = rnd
  b = rnd * .008 + .993  'originally held const .9998
  c = 2 - 2 * a
  x = j = 0
  y = rnd * 12 + .1
  
  'set palette (originally only 6 colors)
  for pc = 0 to int(dots/100)
    red   = int(rnd*2)*(rnd*195+60)
    green = int(rnd*2)*(rnd*195+60)
    blue  = int(rnd*2)*(rnd*195+60)
    ca(pc) = rgb(red, green, blue)
  next
  
  'the outer loop here waits for keypress to move out to new mira
  ? "Start: a = ";a;"   b = ";b
  'while len(inkey) = 0
    for i=0 to dots
      z = x
      x = b * y + j
      j = a * x + c * (x ^ 2) / (1 + x ^ 2)
      y = j - z
      xp = (x * 20) + xc
      yp = (y * 20) + yc
      pset xp, yp, ca(int(i/100))
    next 
'    delay 100
'  wend
  cls
wend
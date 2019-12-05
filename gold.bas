'goldwave by johnno copied and mod 2018-01-28

for t=1 to 60 step .1  '< changed
  cls 'changed
  'rect 0,0,600,600 color dark3 filled
  For y1 = 0 to 24
    For x1 = 0 to 24
      x=(12*(24-x1))+(12*y1)
      y=(-6*(24-x1))+(6*y1)+300
      d= ((10-x1)^2+(10-y1)^2)^.5
      h=60*sin(x1/4+t)+65
      if t>10 and t<20 then h=60*sin(y1/4+t)+65
      if t>20 and t<30 then h=60*sin((x1-y1)/4+t)+65
      if t>30 and t<40 then h=30*sin(x1/2+t)+30*sin(y1/2+t)+65
      if t>40 and t<50 then h=60*sin((x1+y1)/4+t)+65
      if t>50 and t<60 then h=60*sin(d*.3+t)+65
      'TOP
      p1 = [x,y-h,x+10,y+5-h,x+20,y-h,x+10,y-5-h]
      drawpoly p1 color rgb(242+.1*h,242+.1*h,h) filled  '< changed
      'FRONT-LEFT
      p2 = [x,y-h,x+10,y+5-h,x+10,y,x,y-5]
      drawpoly p2 color rgb(255,80,0) filled
      'FRONT-RIGHT
      p3 = [x+10,y+5-h,x+10,y,x+20,y-5,x+20,y-h]
      drawpoly p3 color rgb(255,150,0) filled
      'if inkey$ = chr$(27) then end '<<<<<<<<<<<<<<<<<<<<< this is THE time killer
    next
  next
  showpage '< changed
  delay 20 '<changed
next
rem Welcome to SmallBASIC

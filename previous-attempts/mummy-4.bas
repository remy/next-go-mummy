PLUS3DOS 8   � ��                                                                                                         � 
$ ; Oh Mummy (clone), Remy Sharp 2020  ��2    :�3.5Mhz  ; RANDOMIZE 5  ; 2 �init() < �initBaddies() F ; P ; define player and game state ZG �%x=160  �  :�%y=32     :�%h=%�12347&1:�%l=3    :�%s=56  8  :;s=� d) �%d=1    :�%z=4    :;direction&speed n+ �%t=3    :�%P(2)=10  
  :;t=baddiespeed � ; � ; game loop � ; PROC fps() � ��="s"��10  
  :;restart � ; � ; move player �4 ��0     ,0     ;%l;" x:";%x;",y:";%y;"   ":;lives � �changeTile() � �10  
  ,%x,%y,%s,%d � �%P(0)=%x:�%P(1)=%y � �%j=�31     �# �%(�$fbfe�0&1^1)��%j=%(j+@1000):�Q �# �%(�$fdfe�0&1^1)��%j=%(j+@0100):�A# �%(�$dffe�1&1^1)��%j=%(j+@0010):�O# �%(�$dffe�0&1^1)��%j=%(j+@0001):�P& ; if I can't move on x plane, check y �%x�48�0��%300  �%j&@1000=@1000��7000  X :�up"" �%j&@0100=@0100��7100  � :�down+# ; if I can't move on y plane, skip, �%y�48�0��400  � 6" �%j&@0010=@0010��7200    :�left@# �%j&@0001=@0001��7300  � :�right� ;�6 ; check for map edge TODO only check if value changed� ;�- �%x<48�:�%x=48  0  :��%x>240�:�%x=240  �  �- �%y<48�:�%y=48  0  :��%y>192�:�%y=192  �  � ;�' ; process baddies, current baddie = %b� ;� �%b=0     
 �baddie()$ �%b+1,%B(i),%B(i+1),%B(i+2),%B(i+5) �%b=%b+1:�%b<3��%520� ;� �%200:;loop� ;� ; leave tread marks� ;B �changeTile():;up=0     ,down=1    ,left=2    ,right=3     �%P(2)=10˒ �14    �0     ,%P(2)7 �1    ,1    �0     ,0     �%P(0)/16-2,%P(1)/16-2$ �� ;� ; handle baddies� ;�
 �baddie()�) �%i=%b*6:;6    props(easy�messthisup!)� ; render sprite �%B(i+4)=0˒:;thisbaddieisdead ;U ; print %b,0;%b;":";%x/16 = B(i)/16;"    " IF %x/16 = B(i)/16 AND (y/16 = B(i+1)/16)G �%B(i)-x<16�(B(i+1)-y<16)��%B(i+4)=0     :�%B(i+5)=0     :�%l=%l-1:�  ;> �%j=%B(i+3)H# �%j=1��%3000:�%B(i+1)�48�0˒:;downR! �%j=2��%3100:�%B(i+1)�48�0˒:;up\! �%j=4��%3200:�%B(i)�48�0˒:;leftf" �%j=8��%3300:�%B(i)�48�0˒:;rightp ;z* ; change direction, since we got this far� �%B(i+3)=%1��4:;qaop/direction� �� ;� ; baddie down� ;� �%B(i+1)=%B(i+1)+t�< �%B(i+1)>192�:�%B(i+1)=192  �  :;TODOdecidewhetherwerotate�< �%B(i+2)=55  7  :�%B(i+5)=%B(i+5)^@1000:;set��up,�flipbits� � ;0 ; baddie up: ;D �%B(i+1)=%B(i+1)-tN: �%B(i+1)<48�:�%B(i+1)=48  0  :;TODOdecidewhetherwerotateX< �%B(i+2)=54  6  :�%B(i+5)=%B(i+5)^@1000:;set��up,�flipbitsb �l ;� ; baddie left� ;� �%B(i)=%B(i)-t�6 �%B(i)<48�:�%B(i)=48  0  :;TODOdecidewhetherwerotate�; �%B(i+2)=%B(i+2)+1:�%B(i+2)>53��%B(i+2)=52  4  :;animate�� �%B(i+5)=%@0001:;�flipbits� �� ;� ; baddie right ; �%B(i)=%B(i)+t �%B(i)>240�:�%B(i)=240  �   ; �%B(i+2)=%B(i+2)+1:�%B(i+2)>53��%B(i+2)=52  4  :;animate�* �%B(i+5)=%@1001:;�flipbits4 �> ;W ;X
 ; move upY ;b �%P(2)=0     l	 �%y=%y-zv �%d=%d^@1000� �%s=58  :  � �� ;� ; move down� ;� �%P(2)=1    �	 �%y=%y+z� �%d=%d^@1000� �%s=59  ;  � � ;  ; move left! ;* �%P(2)=2    4	 �%x=%x-z> �%d=%@1001H �%s=%s+1:�%s>57��%s=56  8  R �� ;� ; move right� ;� �%P(2)=3    �	 �%x=%x+z� �%d=%@0001� �%s=%s+1:�%s>57��%s=56  8  � �? ;@ ;J ; initT ;^ �init()c �2    ,1    :�h. �"mummy-clear.spr"�13    :�load spritesheetr' �"mummy-3.map"�14    :�load tile map|' ��13    :�point tiles to spritesheet�^ ��14    ,0     ,16    ,16    :�bank 14, offset 0, tilemap width 16 tiles, tile size 16�@ �16    ,12    :�print tile for 16 tile cols by 12 tile rows�/ �"mummy-clear.spr"�16    ,0     ,4096    � ��13    � �!4 ;!>^ ; initBaddies: %B=Array([x,y,spr,angle(0: x, 1: y),direction(0: backward, 1: forward),alive])!C& ; note: i*j = j properties per baddie!H ;!R �initBaddies()!W �%j=6    :;nprops!\" �%i=0     �2    :;totalbaddies!f �%B(i*j)=60  <  :;%�192+48!p �%B((i*j)+1)=%�4*48+48!z �%B((i*j)+2)=53  5  :;�!�' �%B((i*j)+3)=%1�(�2+2):;qaop/direction!� �%B((i*j)+4)=1    :;alive!� �%B((i*j)+5)=1    :;�flags!� �%i!�8 �255  �  :�0     :�0     :;backgroundblack,textwhite!� ��:��1    !� �&G ;&H �fps()&M �%b&R �%b=%�23672&\	 �%f=%b-a&f �%b<a��%f=%f+256&p �%a=%b&z �&� ;&� ;Quick save&� ;&�5 ; SPRITE PRINT 0: SAVE "mummy-3.bas" LINE 9999: STOP&� ��0     :�"mummy-3.bas":�' ;' ;Boot game' ;' �init():�5    
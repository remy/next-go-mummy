PLUS3DOS o   �n
 �n                                                                                                         $ 
+ ; Oh Mummy (clone), Remy Sharp 2020 / @rem  ;  ��3    :�@ 28Mhz ( ; 2$ ; ************ TODO *************** <B ; - [ ] (bug) can't replicate: crashes at random during game play F. ; - [ ] (bug) can't replicate: baddies freeze P0 ; - [ ] (bug) win game state - text over header Z ; - [ ] (req) Hi-score(?) d[ ; - [ ] (feat) "Get outta there" / "now find the archaeologist" / "find that key!" marquee n, ; - [ ] (feat) AI for baddie & dumb baddies x5 ; - [ ] (feat) Improve background tile/walkway image �$ ; - [~] Welcome screen / start game �H ; - [?] (bug) on start of next level you're thrown out of the beginning �D ; - [x] (bug) without music, pause and unpause, sound effects break �{ ; - [x] (bug) level 4 has corrupted image on tile 7 + 8 - can't replicate in cspect (I was poking a transparent colour in) �+ ; - [x] (bug) score misaligned after I win �! ; - [x] (feat) Add pause support �? ; - [x] (bug) Score position is off when you complete 5 levels �/ ; - [x] (bug) initial life number is incorrect �0 ; - [x] (bug) You ded doesn't draw over sprites �( ; - [x] (feat) Can I colour the border? �$ ; - [x] (req) Game over - Win state �: ; - [x] (feat) Change colours of tombs between each level �_ ; - [x] (feat) When player tries to turn 1 step away from a turn, "help" them and jump over itk ; - [x] (bug) baddies are faster than player (rendering is simpler) (5: baddie slow, 4: baddie same speed)) ; - [x] (feat) Crack effect on tomb edge: ; - [x] (perf) Don't call new round of poke on each level"1 ; - [x] (bug) Fix the top left corner foot steps,Y ; - [x] (perf) Can we make screen transitions faster (tried different methods, prob not)6% ; - [x] Fix tomb 9 affecting tomb 10@6 ; - [x] Fix baddie reveal - and the direction they goJ ; - [x] Baddie revealedT ; - [x] Score^ ; - [x] 10 treasure chestsh6 ; - [x] Open tomb effect (spr@8-11 + 12 transparency)r ; - [x] Level up|! ; - [x] Graphics for prize tombs�1 ; - [x] Possibly allow player in start position?� ;�$ ; ******** VARIABLE INDEX *********� ;�B ; %a = player last corner, used for tomb calc - initilised to $FF�1 ; %A[] = baddie array (allows for > 64 elements)� ; %b = baddie index� ; %c = baddie count�# ; %C[] = palette colours for tombs�) ; %d = player sprite flags (mirror, etc)�K ; %n = delta time counter (only used during dev, but needs to be reserved)� ; %l = player lives�H ; %P = player last position, used for tread marks - initilised to $FFFFT ; %q = player last direction (whilst movement is engaged) - used for movement hacks5 ; %r = (flag) player has scroll and can kill a mummy ; %s = player sprite&7 ; %R() = used to pick random selection of hidden items0 ; %S(...) = speed option array:y ; %T(21) = tomb array 0-19 with index 20 used for temp rendering, with 8bit flags (14 items contain data in the low bit)D% ; %t = items to find - defaults to 2N ; %w = scoreX ; %x = player xb ; %y = player ylK ; %z = speed (for both baddie and player) - calculated based on DIFFICULTYv ; --- non int vars ---�0 ; DIFFICULTY(3) = how many lives you start with� ; LEVEL(1) = current level�& ; SPEED(3) = how fast the baddies are�@ ; PLAYING = bool like - whether we're in game or not (in menus)� ;� ; TMP VARIABLES�o ; i, j, k (but often shared) - then - e, f, g, h, o, u, v (unless documented, are disposable between DEFPROCS)� ;� ; BANK INDEX� ;�" ; 19: tiles (copied from BANK 23)� ; 20: music (mummy.ndr)�! ; 21: music player (nextdaw.drv)2 ; 22: main player and NPC sprites (m-sprites.spr)/ ; 23: tile map (used with BANK 19) (mummy.map)( ; 24: tile data (sprites) (m-tiles.spr) > ; 25: "oh mummy" layer 2 header (1/3 of layer 2) (banner.bin)* ; 26: game over/pause tiles4> ; 27: tomb tiles - extra graphics arranged in a useful layout>J ; 28: palette - let's me change level colours without additional graphicsH  ; 29: sound effects (mummy.afb)RF ; 30: temp holding space for 1/3rd of layer 2 screen (used for pause)\ ; 31-33: screen cover imagef ;p% ; **********************************z ;� ;PROC dT()� ;PROC splash()� DEBUG=0     � SPRITEON=1    � BOOT=0     �( ;IF NOT DEBUG THEN ON ERROR PROC exit()� �initOnce()� �initNewGame()� �mainLoop()�= ; game loop - includes: render loop, lives check & game over� �mainLoop()� �� �Q ;IF DEBUG THEN IF INKEY$ ="s" THEN SPRITEON= NOT SPRITEON: SPRITE PRINT SPRITEONR ;IF DEBUG THEN PRINT AT %1,%0;"mem=";%65536- USR 7962;" ": ; memory available....5 �DEBUG���="t"�%t=0     :; FIXME remove TESTING ONLY$5 �DEBUG���="d"�%l=0     :; FIXME remove TESTING ONLY.C �DEBUG���="w"�LEVEL=5    :%t=0     :; FIXME remove TESTING ONLY8 �DEBUG��0     B( �updateLoop():; update logic and renderL �DEBUG��2    V  ��%l=0�(t=0):; until zero lives`< �%t=0˓nextLevel(LEVEL+1    ):��gameOver():�initNewGame()j ��0     :; repeat forevert �~ ;�I ; start main game loop - we do only one thing at a time in the main loop� �updateLoop()� �updatePlayer(%8)� �%b=1    :; baddie loop� ��* %i=%b*6:; 6 props (easy to mess this up!)� �%��b<2˓updateBaddie()�	 �%b=%b+1� ��%b=(c+1)� ��="h"˓pauseGame()�G �Ѻ :;without INT itseems TO RUN atinybitsmoother ON tombintersections�E �%m�-1˕49  1  ,2    ,%m:%m=%-1:; play the activated sound effect J ;PROC dT() TO %f: PRINT AT 0,0;%c;"@";%f;" ": ; f big = bad, small = good
 � ; �updatePlayer(%z)(I �treadMark():; put treadmarks on the place we're about to move away from21 �%j=�31    :; check the joystick and then keys<V ; help the player when turning corners - but only with the joystick, not the keyboardF? �%j��%y�40�(y>$ff)��%(j&@0011)=j�%j=%j+q:; add the y directionP7 �%j��%x�48��%(j&@1100)=j�%j=%j+q:; add the x directionZL ; NOTE: these shifts aren't always needed, but it makes the code consistentd" �%(�$fbfe�0&1^1)��%j=%j+@1000:; Qn" �%(�$fdfe�0&1^1)��%j=%j+@0100:; Ax" �%(�$dffe�1&1^1)��%j=%j+@0010:; O�" �%(�$dffe�0&1^1)��%j=%j+@0001:; P�i ; NOTE I no longer do an early exit - this keeps the game speed constant, otherwise the baddies speed up�L ; IF %j&$0f=0 THEN LET %P=%$ffff: ENDPROC : ; play isn't moving, early exit�B ; the last direction is stored in the up/down/left/right routines�( ; If I can't move on the x plane,checky�7 �%x�48�:�:�%j&@0100˓down(%z):��%y>0�(j&@1000)˓up(%z)�0 �checkTomb():; %P = $ffff if they haven't moved�< �%y�40�(y>$ff)�:�:�%j&@0010˓left(%z):��%j&@0001˓right(%z)�Q ; note that %x > $ff means the integer has gone from 0, to -1, but it's unsigned�L ; so it'll be up in the 65K range, so this check against 255 is good enough�- �%x>$ff�:�%x=0     :��%x>240�:�%x=240  �  �Y �%t=1��%j&@1000�(y=0)�(x=96)˓up(%z):%t=0     :%m=2    :�64  @  ,%x+32,%y+48,%s,%d:��D �%y=$FFF0�(y=$FFF8)�:�:�%y>$ff�:�%y=0     :��%y>160�:�%y=160  �  	 ; render �64  @  ,%x+32,%y+48,%s,%dK ; check the 2nd tomb _after_ sprite render to help smooth out the movement" �checkTomb(),' ; check if we're bumping into a baddie6 %i=%��(64,1�c)@ �%i=0˒J �%i,,,,0     T %i=%i*6^6 �%A[i+4]=0˒:; ignore hidden zombies/inactive baddiesh %A[i+4]=0     r %A[i+5]=0     |* �%r=0�:%m=5    :�takeLife():�%r=0     � �� ;� �checkTomb()�X ; IIRC the PAUSE 1 is to attempt to match the timing if the player _had_ openned a tomb�1 �%(x�48)�(y�40)��1    :�:; only run on corners�K �%i=%(6*(y/40))+(x/48):; x/y as aisle index (6 aisles for 5 rows of tombs)�< �%i=a��1    :�:; we were just there (%a is last position)� �%a=$ffff�%a=%i:�1    :��) %f=%i-a:; f is forward +1 or backward -1�9 %k=%��{f}=1    :; k tracks the axis, +1 for X, 0 for Y�I ; important: %g is assigned here and used within getXTombs and getYTombs� �%�{f<0}�%g=%a:�%g=%i�+ �%k˓getXTombs()�%g,%h:��getYTombs()�%g,%hF ; note that index 20 is out of bounds and assigns to the junk element= �%g<20˓crackEdge(%k,%g,%T(g),1    ,%@11011111,%@10111111)= �%h<20˓crackEdge(%k,%h,%T(h),0     ,%@01111111,%@11101111)&@ %a=%f+a:; save the last position (reverting from %f we lost %i)0 �: ;D1 ; getXTombs: get tombs above and below of playerN �getXTombs()X ; %g from checkTombb %h=%1+(g/6)l %i=%g-hv
 �=%i-5,%i� ;�7 ; getYTombs: get tombs on the left and right of player� �getYTombs()� ;%g is from checkTomb�C ; this uses special logic for the left and right edge of the grid,�@ ; otherwise when you complete tomb 4 (x:4, y:0) then it wrongly�B ; applies a completed edge to 5 (x:0, y:1). The logic below fixes�? ; that - and returns '21' for a non existant/out of scope tomb� %v=%(g+1)�6�+ �%v>1�%i=%g-6-(g/6):�=%i,%i+1:; inner grid�> �%v=1�%i=%g-6-(g/6):�=21    ,%i+1:; completed on right edge�8 �=%g-6-(g/6),21    :; case 0 = completed on left edge� ; �crackEdge(%k,%i,%j,%o,%a,%b)L ; cache the curent value, and if it doesn't change, nothing to do / endproc
 �%j&8=8˒ 6 %u=%2+((i�5)*6):; map X to the x coord in tile offset* %v=%4+((i/5)*5):; same with Y4V ; bitwise op below is $current wall & (0xF0 + wall, 1 top, 2 right, 4 bottom, 8 left)>c ; importantly this leaves the first 4 bits untouched (Least Significant Nibble) meaning: @00001111H! �%k�%T(i)=%T(i)&a:�%T(i)=%T(i)&bR �%T(i)=j˒\ ; print the cracked tilefV �%k˛4    ,1    �0     ,%24+o�%u,%v+(o*2):��1    ,3    �%0+o,%21�%u+(o*3),%vp	 %j=%T(i)z* ; only continue if the tomb is fully open� �%j&$f8�0˒�, ; open tomb (ie. slightly different colour)�' �4    ,3    �0     ,3    �%u,%v�? �%m=4�:�:�%j=0�(j=4)�%m=0     :��%j>2�%m=1    :�%m=4    :�( �4    ,3    �0     ,%(3*j)+3�%u,%v�@ ; archaeologist(1), key(2), amulet(3), baddie(4) or treasure(5)�B �%j=1�%t=%t-1:%w=%w+50:��%j=2�%t=%t-1:��%j=3�%r=%1:��%j=5�%w=%w+5�A ; if we revealed a baddie, bring them to life, and kick them offԓ �%j=4�%A[6+4]=%$ff:%A[6+3]=3    :�1    ,,,%A[6+5]-4,1    :��1    ,�,%A[7]�%A[7]+16�1    �,%A[6+5]-4�%A[6+5]-1,�10    ,1    ,20    �2 %T(i)=%j+8:; prevent the tomb from being reopened� �printScore()� �� ;	 ; leave tread marks	) �treadMark():;down=0,up=2,left=4,right=6	 �%P=$ffff˒:; didn't move	$8 �%P>3�%i=%(x�3)�2:�%i=%(y�3)�2:; if left +1, right = -1	. ;	8 %v=%(y�3)+2	B> �%v>8000�%v=%v�8192:; handle when player is in start position	L1 ; IF %P=0 THEN TILE 2,1 AT 0,%26+i TO %x >> 3,%v	V3 ; IF %P=2 THEN TILE 2,1 AT 2,%26+i TO %x >> 3,%v+1	`3 ; IF %P=4 THEN TILE 1,2 AT %0+i,28 TO %x >> 3+1,%v	j1 ; IF %P=6 THEN TILE 1,2 AT %2+i,28 TO %x >> 3,%v	tB ; The four above lines can be refactored into a single line below	~^ �%P<3˛2    ,1    �%P,%26+i�%x�3,%v+(P�1):��1    ,2    �%P-4+i,28    �%x�3+(P�3),%v	�! %P=%$ffff:; now we're not moving	� �	� ;	� ; handle baddies	� ;	� �updateBaddie()	�$ ; if this baddie is dead, fast exit	� �%A[i+4]=0˒	� %f=%��(b,0):; x	� %g=%��(b,1):; y	�O ; select a random direction 0-3 is valid, but if we have a random value higher	�O ; then decide whether the baddie should chase the goodie, or keep going in the
  ; current direction

 %j=%�12
 �%j>3�%j=%A[i+3]
= ; if they're on the edge of the map, don't let them walk off
( �%g=208��%j=0�%j=1    
2 �%g=48��%j=1�%j=0     
< �%f=272��%j=2�%j=3    
F �%f=32��%j=3�%j=2    
P ; save their direction
Z %A[i+3]=%j
d ; FIXME what does this do?
n %A[(i*j)+2]=0     
xM ; this handles an edge case whereby the baddie is being revealed from hiding
�] ; and they're not on the right Y plane, so the distance to the next intersection is adjusted
� %v=%48
�& �%(f-32)�48�0�%v=%32:�%j<2�%j=2    
�k ; Note: I don't make use of the sprite mirror flag, instead I'm storing all the permutations of the sprite
�f ; because I have room, and it means that I don't need an IF and subsequent SPRITE statement, i.e. the
� ; fastest code is no code.
� %e=%A[i+5]
�G �%j=0˞�%b,�,%g�%g+40�%z�,%e-4�%e-3,�10    ,0     ,0     :�:; down
�I �%j=1˞�%b,�,%g-40�%g�%�{-z}�,%e-2�%e-1,�10    ,0     ,0     :�:; up
�E �%j=2˞�%b,%f�%f+v�%z�,�,%e�%e+1,�10    ,0     ,0     :�:; right
�J �%j=3˞�%b,%f-v�%f�%�{-z}�,�,%e+2�%e+3,�10    ,0     ,0     :�:; left
� �
� ; �takeLife() %l=%l-1 �%i=1    �%l"' �%50+i,%16,%32+(i*14),54  6  ,1    , �%i6 �%i=%l+1�%�{DIFFICULTY}@' �%50+i,%16,%32+(i*14),55  7  ,1    J �%iT �^ ;h �up(%z):; move upr %q=8    |K %P=2    :; I'm fairly certain that q and P do pretty much the same thing� %y=%y-z� %d=%d^@1000� %s=50  2  � �� ;� �down(%z):; move down� %q=4    � %P=0     � %y=%y+z� %d=%d^@1000� %s=51  3  � �� ; �left(%z):; move left %q=2     %P=4    & %x=%x-z0
 %d=%@1001: %s=%s+1:�%s>49�%s=48  0  D �N ;X �right(%z):; move rightb %q=1    l %P=6    v %x=%x+z�
 %d=%@0001� %s=%s+1:�%s>49�%s=48  0  � �� ;�	 �pad(%w)� �%w<10˒="000"� �%w<100˒="00"� �%w<1000˒="0"� �=""� ;� �printScore()� w$=""� �%w<1001˓pad(%w)�w$ ��0     ,6    ;w$;%w � ;  ; init functions* ;4 �initSprites()>( ��:�2    ,1    :��1    :��1    H �19    �R$ �23    ��19    :; reset the map\^ ��19    ,0     ,32     ,8    :; using tile bank 19, offset 0, tile 32 wide, tile size 8fA �32     ,24    :; print tile for 14 tile cols by 12 tile rowsp? ��27    ,0     ,4    ,8    :; swap to our tomb tile setzA ��:; switch to batching (though pretty sure this isn't required)� �� ;� �setBorder(%n)� �1    ,0     :��9  	  �L �28    �%(512+32),%((n&1)�8)+(n�1):; poke 16bit little endian next colour�	 �0     � ��0     �28    ,512    �0 �2    ,1    :; re-select our original layer� �0     :�255  �  � �� ;� �pauseGame()�T ; note that this tiles with a black with priority set, so it will sit above sprites �2    ,1     ; backup the screen �10  
  ��30    $ ; stop the music. �50  2  ,4    8 ; paint it blackB$ ��26    ,0     ,16    ,8    L2 �16    ,3    �0     ,2    �8    ,8    V3 �16    ,3    �0     ,2    �8    ,11    ` %i=13    j5 �1    ,1    �10  
  ,0     �%i+0,10  
  :;  Pt4 �1    ,1    �11    ,0     �%i+1,10  
  :; A~4 �1    ,1    �12    ,0     �%i+2,10  
  :; U�4 �1    ,1    �13    ,0     �%i+3,10  
  :; S�4 �1    ,1    �14    ,0     �%i+4,10  
  :; E�4 �1    ,1    �15    ,0     �%i+5,10  
  :; D� �pressAnyKey()� ; resume music if it wass on�+ �MUSIC˕50  2  ,2    :�50  2  ,3    � ; restore the screen� �30    ��10  
  � ; put original tiles back�# ��27    ,0     ,4    ,8    � �� ;  �gameOver()
 �0     :�255  �  T ; note that this tiles with a black with priority set, so it will sit above sprites �2    ,1    ($ ��26    ,0     ,16    ,8    22 �16    ,3    �0     ,2    �8    ,9  	  <3 �16    ,3    �0     ,2    �8    ,12    F3 �16    ,3    �0     ,2    �8    ,15    P1 �49  1  ,2    ,3    :; play game over soundZ �%i=%0�%20:�1    :�%idO �1    ,1    �0     ,0     �8    ,12    :�%i=%0�%20:�1    :�%i:;  GnO �1    ,1    �1    ,0     �10  
  ,12    :�%i=%0�%20:�1    :�%i:; AxO �1    ,1    �2    ,0     �12    ,12    :�%i=%0�%20:�1    :�%i:; M�O �1    ,1    �3    ,0     �14    ,12    :�%i=%0�%20:�1    :�%i:; E�O �1    ,1    �4    ,0     �17    ,12    :�%i=%0�%20:�1    :�%i:; O�O �1    ,1    �5    ,0     �19    ,12    :�%i=%0�%20:�1    :�%i:; V�O �1    ,1    �6    ,0     �21    ,12    :�%i=%0�%20:�1    :�%i:; E�O �1    ,1    �7    ,0     �23    ,12    :�%i=%0�%20:�1    :�%i:; R�W �7    ,1    �0     ,1    �12    ,14    :�%i=%0�%20:�1    :�%i:; "you ded"� �pressAnyKey()� ��� �� ;� ; initBaddies: %A=Array[[x,y,spr,angle(0: x, 1: y),direction(0: backward, 1: forward),alive]] (allowing for more than 10 baddies)�& ; note: i*j = j properties per baddie� �initBaddies() �%j=6    :;n props �%i=1    �%c �%A[i*j]=%(�6)*48:; 0 = x"C �%A[(i*j)+1]=%40+(�4*40):; 1 = y - baddies start on bottom 3 rungs,5 �%A[(i*j)+2]=0     :; 2 = delay (used to be SPRITE)6% �%A[(i*j)+3]=%�4:;3 = qaop/direction@[ ; if we're on the last baddie, then we'll set them to dead, but they'll come to life laterJt �%i=1�%A[(i*j)+4]=%$0:�%A[(i*j)+4]=%$ff:; 4 = alive (note to self: I changed this to 1 and baddie walked backwards)TA �%A[(i*j)+5]=%44-(8*(c-i)):; 5 = sprite offset (for baddie type)^8 �%i,%A[i*j]+32,%A[(i*j)+1]+48,%A[(i*j)+5],%1&A[(i*j)+4]h �%ir �| ;� �initTombs()�T �%i=0     �20    :; note that index 20 is used for dumping invalid/out of bounds�k �%T(i)=%$f0:; this is 11110000 - each edge is the high nibble and set as closed/waiting to be masked later� �%i� �pickRandom()�2 ; %W(3)=%4 :; use to force hidden baddie position�M ; generates: scroll (0), archaeologist (1), key (2), hidden mummy/baddie (3)�
 �%i=%0�%3� %T(W(i))=%T(W(i))+(i+1)� �%i�" ; PRINT AT 22,0;"Hidden @ ";%W(3)� ; hides the baddie in a tomb� %A[6]=%(W(3)�5)*48+32+32 %A[7]=%(W(3)/5)*40+24+48 �1    ,%A[6],%A[7],,, ;& ; treasures x 50
 �%i=%4�%9: %T(W(i))=%T(W(i))+5D �%iN �X ;b �pickRandom()l �%n:�%p:�%tv. %v=20    :; select from 0-20 (excluding 20)� %p=14    :; pick 4 numbers� %i=0     � ; init the 0-N array� ��	 %R(i)=%i� %i=%i+1� ��%i=v�& ; then go back downwards for P values� �� %t=%�i�4 %W(v-i)=%R(t):; W is our global (winning positions)� %i=%i-1� %R(t)=%R(i) ��%i=(v-p)! ; pickings are in global array W �  ;* �loadAssets()4 ��> �2    ,1    H �252  �  :�0     :�0     :R ��\8 ; allows for stop and start when music is running stillf ���:�50  2  ,4    :��p( ���:.uninstall "assets/nextdaw.drv" :��z .install "assets/nextdaw.drv"�% ���:.uninstall "assets/ayfx.drv" :��� .install "assets/ayfx.drv"�M ; note: I'm being a bit lavish with my banks here, but I could pretty easily�M ; upgrade the .map files to exist in a single file and single bank, just use�/ ; offsets (same goes with .pal, .adb and .bin)�6 �"assets/mummy.ndr"�20    :; plus bank 21 for music�, �"assets/m-sprites.spr"�22    :��22    �Y �"assets/mummy.map"�23    :;load tile map created at https://zx.remysharp.com/sprites/�G �"assets/m-tiles.spr"�24    :��24    :; load spritesheet for tiles�  �"assets/gameover.map"�26    � �"assets/tombs.map"�27    � �"assets/mummy.pal"�28    �- �"assets/mummy.afb"�29    :; sound effects �"assets/font.bin"�64000   � * ; bank 30 is used for temp layer 2,1 data= �"assets/banner1.bin"�31    :; header for non-game screens$= �"assets/banner2.bin"�32     :; header for non-game screens.= �"assets/banner3.bin"�33  !  :; header for non-game screens8 �B ;L �initOnce()VC �loadAssets():; separate load allows for future single tape loader` %m=%-1j PLAYING=0     t DIFFICULTY=3    ~ SPEED=3    �
 %S(1)=%12�
 %S(2)=%10�	 %S(3)=%8�	 %S(4)=%6�	 %S(5)=%4�	 %C(1)=%0�
 %C(2)=%16� %C(3)=%236�
 %C(4)=%82� %C(5)=%128� MUSIC=�DEBUG� ; music , �50  2  ,1    ,0     ,20    :; BANK20
, �50  2  ,1    ,1    ,21    :; BANK21 �50  2  ,2    :; Init Song% �MUSIC˕50  2  ,3    :; Play Song( ; sound effects2 �49  1  ,1    ,29    < ; fontF% �23606  6\ ,63744   � :; 64000-256P �2    ,1    Z* ��2    :; trigger the font to be loadedd5 ; reduce the font into 7x8 (bit more space to write)n( ;PRINT CHR$ 30; CHR$ 7; CHR$ 31; CHR$ 7x ; colour palette�
 ��9  	  � ��0     �28    ,0     �
 ��0     �; �23658  j\ ,0     :; turn off CAPS LOCK (for menu items)� �� ;� �initGameVars()� �%x=%96�	 �%y=%-16� �%s=%51:; s=sprite� �%q=%0:; last direct� �%d=%1:; direction & speed�# �%P=%0:; %P = last player position �%a=%$ffff" �%r=%0:; can player kill a mummy? �%t=%3" �, ;6
 �youWin()@ LEVEL=1    J �setBorder(%0)T SPEED=SPEED+1    ^
 ��0     h
 �header()r �%y=6    | �narrowFont()�F ��%y-1,12    ;�29    ;�1    ;"YOU DID IT!!!";�29    ;�0     �, ��%y+2,1    ;"You saved all five of the "�3 ��%y+3,1    ;"archaeologists. They're safe back"�/ ��%y+4,1    ;"home drinking tea and dunking"�' ��%y+5,1    ;"biscuits. Great work!"�4 ��%y+8,1    ;"But...a hero's work is never done."�/ ��%y+9,1    ;"More archaeologists have gone"�4 ��%y+10,1    ;"walkies, and they need your help."�2 ��%y+12,1    ;"Will you survive the challenge?"� �resetFont()� �0     :�252  �  �& ��%y+14,13    ;"Onward adventurer!"� �252  �  :�0      �pressAnyKey() � ;& �initNewGame()0 �welcome(): %w=0     :; scoreD ; define player and game stateN %z=%S(�{SPEED}):; baddie speedX %l=%�{DIFFICULTY}:; livesb PLAYING=1    l �resetFont()v �nextLevel(1    )� �� ;� �nextLevel(l)�	 �0     � LEVEL=l� �LEVEL=6    ˓youWin()� %j=%�{LEVEL}�+ %c=%j+1:; baddies increase with each level� ; 0x150, 0x1f8, 0x1e8, 0x168� ; offset values:�F ; yellow (0), orange (16), purple (236), party pink (82), green (128)� �2    ,1    �* %i=%C(j):;%i=%82 : ; used to test colours ��0     ,33  !  ,%$150-i ��0     ,34  "  ,%$1f8-i ��0     ,35  #  ,%$1e8-i  ��0     ,36  $  ,%$168-i* �initSprites()4 �setBorder(%$168-i)> �initBaddies()H �initTombs()R �initGameVars()\* �treadMark():; depends on player positionf9 %l=%l+1:; stupid, but can't be bothered to add more codep  �takeLife():; renders the livesz" %w=%w+�{(LEVEL-1    )*50  2  }� �printScore()�1 ; show how many archaeologist's are left to save� �%i=2    �LEVEL�( �%55+i,%290,%14+(i*18),52  4  ,1    � �%i� �%i=LEVEL+1    �6    �( �%55+i,%290,%14+(i*18),53  5  ,1    � �%i� ; wait for a key up�	 �:���=""� �� ;� �dT() �%g=%�23672	 �%f=%g-n �%g<n��%f=%f+256$ �%n=%g. �=%f8 ;B
 �splash()L �2    ,1    :�V .bmpload assets/welcome.bmp`	 �0     j ��:��t �~ ;� �optionsScreen()�
 �header()� �%y=9  	  � DIFFICULTY=0     � %z=0     �, ��%y+1,5    ;"Speed of baddies [1-5] ? �"�$ ��%y+2,5    ;"    (1 is fastest)"� �100  d  � �� �Ѻ� �%j=%�{��}-$30� �%j<6�%z=%j  ��%z�0
 ��%y+1,30    ;%z	 SPEED=%z %z=%S(�{SPEED})(* �:���="":; wait until the key is up again2, ��%y+4,5    ;"Difficulty level [1-5] ? �"<$ ��%y+5,5    ;"    (1 is hardest)"F �P �ѺZ �%j=%�{��}-$30d �%j<6�DIFFICULTY=%jn ��DIFFICULTY�0     x ��%y+4,30    ;DIFFICULTY�* �:���="":; wait until the key is up again� MUSIC=2    �, ��%y+7,5    ;"Background music [Y-N] ? �"� �� �Ѻ� c$=��+ �c$="n"�MUSIC=0     :��%y+7,30    ;"No"�, �c$="y"�MUSIC=1    :��%y+7,30    ;"Yes"� ��MUSIC<2    �F �MUSIC=0     ˕50  2  ,4    :��50  2  ,2    :�50  2  ,3    �* �:���="":; wait until the key is up again� �� ; �narrowFont()8 ��0     ,0     ;�30    ;�7    ;�31    ;�7     �" ;, �resetFont()68 ��0     ,0     ;�30    ;�8    ;�31    ;�8    @ �J ;T �creditScreen()^
 �header()h �%y=9  	  r ��%y,2    ;"CREDITS"|( ��%y+2,2    ;"Written by Remy Sharp";�. ��%y+3,2    ;"https://remysharp.com / @rem"�( ��%y+5,2    ;"Sprites by Remy's kids"�+ ��%y+7,2    ;"Music by Richard Faulkner"�Y ; font: https://spectrumcomputing.co.uk/entry/25364/ZX-Spectrum/The_8bit_Font_Collection�+ ��%y+9,2    ;"Font by Paul van der Laan"� �0     :�252  �  � ��%y+11,24    ;"Continue..."� �252  �  :�0     � �pressAnyKey()� �� ;� �helpScreen()�
 �header() �%y=9  	  @ ; 123456789012345678901234567890123456 (total column count: 36)( ��%y,2    ;"Rescue the original 1984"&0 ��%y+1,2    ;"archaeologist party from their"0, ��%y+2,2    ;"failed pyramid plundering.":3 ��%y+5,2    ;"Navigate five catacombs, avoiding"D- ��%y+6,2    ;"the guardians, rescue those"N- ��%y+7,2    ;"muppets and bring them back"X ��%y+8,2    ;"to Blighty."b �0     :�252  �  l ��%y+11,24    ;"Continue..."v �252  �  :�0     �@ ;PAUSE 50: REPEAT : SPRITE MOVE INT : REPEAT UNTIL INKEY$ <> ""� �pressAnyKey()� �%y=8    �
 �header()� ; the tokens from tombs.map�$ ��27    ,24    ,4    ,8    �- �4    ,3    � 0     ,0     �2    ,%y�/ �4    ,3    �12    ,0     �2    ,%y+3�/ �4    ,3    �24    ,0     �2    ,%y+6�/ �4    ,3    �48  0  ,0     �2    ,%y+9�" ��%y+1,6    ;"Rescue this dude"�, ��%y+4,6    ;"Key to escape the catacomb"�% ��%y+7,6    ;"Vanquish a guardian"' ��%y+10,6    ;"Gems means hi-scores" �0     :�252  �   ��%y+12,24    ;"Continue..."  �252  �  :�0     *@ ;PAUSE 50: REPEAT : SPRITE MOVE INT : REPEAT UNTIL INKEY$ <> ""4 �pressAnyKey()>
 �header()H �%y=6    R ��%y+3,2    ;"CONTROLS"\0 ��%y+5,2    ;"Kempton joystick and keyboard";f ��%y+7,2    ;"Q= up"p ��%y+8,18    ;"A= down"z ��%y+7,18    ;"O= left"� ��%y+8,2    ;"P= right"�! ��%y+9,2    ;"H= halt / pause"�0 ��%y+11,2    ;"Surround a tomb to reveal the"�/ ��%y+12,2    ;"contents. Don't get chomped!"� �0     :�252  �  � ��%y+14,24    ;"Continue..."� �252  �  :�0     �@ ;PAUSE 50: REPEAT : SPRITE MOVE INT : REPEAT UNTIL INKEY$ <> ""� �pressAnyKey()� �creditScreen()� �� ;�
 �header() �252  �  :�0     :�0     8 ; important: I'm not using CLS as this method is faster5 ; otherwise there's a visible screen clear and reset$7 �31    ��9  	  :; Oh Mummy header 1/3 (banner1.bin).* �32     ��10  
  :; Oh Mummy header 2/38* �33  !  ��11    :; Oh Mummy header 3/3B �L ;V �playScreen()`
 �header()j �%y=9  	  t ; make the font massive :)~ ��29    ;�1    �) ��%y,6    ;"Rescue the archaeologists"�# ��%y+2,8    ;"    Save the day!"�$ ��%y+4,8    ;"   Don't get eaten"�% ��0     ,0     ;�29    ;�0     �3 �11    �%$2400,%$1c00,0     :; last 4k is black�I ��%21,0     ;�0     ;�252  �  ;"I-Instructions   O-Options    P-Play"� �� ;� �welcome()� �DEBUG˒:; FIXME remove� �setBorder(%0)� PLAYING=0       ��

 ��0      ��22     ��24    (A ��:; switch to batching (though pretty sure this isn't required)2
 ��1    < �%x=304  0 :�%y=208  �  F  �64  @  ,%x,%y,48  0  ,%@1001P! �63  ?  ,%x,%y,46  .  ,1    ZU ��64  @  ,0     �%x�-8    �,�,48  0  �49  1  ,�0001000    ,3    ,200  �  dU ��63  ?  ,0     �%x�-8    �,�,46  .  �47  /  ,�0001000    ,3    ,225  �  n �x �narrowFont()� �playScreen()� �� c$=��$ �c$="i"˓helpScreen():�playScreen()�' �c$="o"˓optionsScreen():�playScreen()� �Ѻ� ��c$="p"ſ31    =16    � ��� �� ;� �pressAnyKey()� �:�Ѻ:���=""�" �:�Ѻ:����""�(�31    =16    ) �:�Ѻ:���="" � ;" �reportErr(), ��err,lin,st6 e$=�err@ ���:�50  2  ,4    :��J( ���:.uninstall "assets/nextdaw.drv" :��T% ���:.uninstall "assets/ayfx.drv" :��^ �2    ,1    h ��r ��| ��� �� �7    :�0     :�7    � ��0     :; turn off sprites� ��30    ,�- �"Error:";e$;", line:";lin;", statement:";st� �waitForKeyClear()� �� ;� �exit()� ; use break to exit mid-game�& �PLAYING˓initNewGame():�mainLoop():�� �9999  ' � �  ;&�) �:��:��:��0     :�"mummy.bas"�0     :�' �2    ,1    :; soft reset
PLUS3DOS G	   � ��                                                                                                         �  ;RUN AT 2: REM run fast 
 �2    ,1    :� ; �255  �  :�0     :�0     :�background black, text white * �"mummy-2.spr"�13    :�load spritesheet (' �"mummy-2.map"�14    :�load tile map 2' ��13    :�point tiles to spritesheet 7^ ��14    ,0     ,16    ,16    :�bank 14, offset 0, tilemap width 16 tiles, tile size 16 <@ �16    ,12    :�print tile for 16 tile cols by 12 tile rows d+ �"mummy-2.spr"�16    ,0     ,4096     n ��13     x ��:��1     �' �%x=48  0  :�%y=48  0  :�%z=41  )   �# �%d=�1:�%s=4    :�prop and speed � �8000  @ L �check position` �%x<48��%x=48  0  e �%x>240��%x=240  �  j �%y<48��%y=48  0  o �%y>192��%y=192  �  � �%o=�57342  �� � �%q=�64520  � � �%a=�65278  �� �" ��0     ,0     ;%x;"/";%y;"   "� �0     ,%x,%y,%z,%d� ; combined movement�" �%j=�31    :; read the joystick�, ��10  
  ,0     ;%j;"--";%j & @1000;"   "�# �%(�$fbfe�0&1^1)��%j=%(j+@1000):�q�# �%(�$fdfe�0&1^1)��%j=%(j+@0100):�a�# �%(�$dffe�1&1^1)��%j=%(j+@0010):�o�# �%(�$dffe�0&1^1)��%j=%(j+@0001):�p�& �%j&@1000=@1000  � ��7000  X :�up( �%j&@0100=@0100  d  ��7100  � :�down( �%j&@0010=@0010  
  ��7200    :�left) �%j&@0001=@0001    ��7300  � :�rightT �8100  � � �1100  L � �1000  � X	 �move up] �%x�48�0��b	 �%y=%y-sl �%d=%d^�00001000v �%z=48  0  � �� �move down� �%x�48�0���	 �%y=%y+s� �%d=%d^�00001000� �%z=45  -  � �  �move left% �%y�48�0��*	 �%x=%x-s4 �%d=�00001001> �%z=%z+1:�%z>43��%z=41  )  H �� �move right� �%y�48�0���	 �%x=%x+s� �%d=�00000001� �%z=%z+1:�%z>43��%z=41  )  � �@
 ; baddiesE �nb=1    J �b(nb,4    )T �i=1    �nb^' �b(i,1    )=�(�*48  0  ):; baddie.xh2 �b(i,2    )=48  0  :;INT ( RND *48):; baddie.yr �b(i,3    )=38  &  | �b(i,4    )=1    :; alive� �i� �� �i=1    �nb�F �b(i,1    )=b(i,1    )+1    :�b(i,3    )=b(i,3    )+1    � �%x:�%x=b(i,1    )�. �b(i,3    )>40  (  ��b(i,3    )=38  &  � �%x<48��%x=48  0  � �%x>240��%x=240  �   3 �0     ,%x,b(i,2    ),b(i,3    ),b(i,4    )  �i  �' �' �:�"mummy-2.bas"
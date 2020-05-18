# Oh Mummy - Spectrum Next clone

This is my working directory for a clone of Oh Mummy based on the CPC464 by Amsoft ported to the ZX Spectrum Next using NextBASIC.

---

Also in this repository are the previous attempts at a NextBASIC version of Oh Mummy kept partly for learning, partly for my own amusement.

Numerically lower files are older, `mummy-1.bas` being the oldest.

General way points:

- [mummy-1.bas](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-1.bas.txt) - has a working sprite, uses `INKEY$` for directions and block characters `█` for the wall
- [mummy-2.bas](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-2.bas.txt) - starts to introduce `TILE BANK` but also adding Kemptston joystick support via bitwise checks on `IN 31`. Also uses tests like `IF %y MOD 48 <> 0 THEN RETURN` to check whether the player can move along an isle.
- [mummy-3.bas](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-3.bas.txt) - introducing baddies using an array to render, also using `DEFPROC` for a bit more organisation
- [mummy-4.bas](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-4.bas.txt) - mostly a refactor to clean code and make it slightly more readable, adds tracking lives and combines keyboard and joystick movement
- [mummy-5.bas](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-5.bas.txt) - more code reorg, adding footsteps (wrongly aligned) and a lot of code optimisations specific to NextBASIC.
- [mummy-6.bas](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-6.bas.txt) - finally solved logic for completing a circuit of a tomb (which is [gnarly](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-6.bas.txt#L52-L66!), also moves to `SPRITE CONTINUE` for better sprite rendering.
- [tomb-check.js](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/tomb-check.js) - JavaScript (my native tongue) code to solve tomb surrounding logic

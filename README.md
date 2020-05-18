# Oh Mummy - Spectrum Next clone

This is my working directory for a clone of Oh Mummy based on the CPC464 by Amsoft ported to the ZX Spectrum Next using NextBASIC.

---

Also in this repository are the previous attempts at a NextBASIC version of Oh Mummy kept partly for learning, partly for my own amusement.

Numerically lower files are older, `mummy-1.bas` being the oldest.

General way points:

- [mummy-1](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-1.bas.txt) - has a working sprite, uses `INKEY$` for directions and block characters `█` for the wall ([.bas file](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-1.bas))
- [mummy-2](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-2.bas.txt) - starts to introduce `TILE BANK` but also adding Kemptston joystick support via bitwise checks on `IN 31`. Also uses tests like `IF %y MOD 48 <> 0 THEN RETURN` to check whether the player can move along an isle ([.bas file](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-2.bas))
- [mummy-3](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-3.bas.txt) - introducing baddies using an array to render, also using `DEFPROC` for a bit more organisation ([.bas file](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-3.bas))
- [mummy-4](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-4.bas.txt) - mostly a refactor to clean code and make it slightly more readable, adds tracking lives and combines keyboard and joystick movement ([.bas file](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-4.bas))
- [mummy-5](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-5.bas.txt) - more code reorg, adding footsteps (wrongly aligned) and a lot of code optimisations specific to NextBASIC ([.bas file](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-5.bas))
- [mummy-6](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-6.bas.txt) - finally solved logic for completing a circuit of a tomb (which is [gnarly](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-6.bas.txt#L52-L66!), also moves to `SPRITE CONTINUE` for better sprite rendering ([.bas file](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/mummy-6.bas))
- [tomb-check.js](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/tomb-check.js) - JavaScript (my native tongue) code to solve tomb surrounding logic

I'm developing on my Mac using my [NextBASIC VS Code extension](https://marketplace.visualstudio.com/items?itemName=remysharp.nextbasic), previewing in [Cspect](http://cspect.org/) then running hardware tests on my ZX Spectrum Next.

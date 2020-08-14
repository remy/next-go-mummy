# Go Mummy - Spectrum Next clone

This is my working directory for a clone of Oh Mummy based on the CPC464 by Amsoft ported to the ZX Spectrum Next using NextBASIC.

![](https://remysharp.com/images/devlog/gomummy.png)

---

**The completed game is available at https://remysharp.itch.io/go-mummy** (where you can donate if you'd like to… I'm sure you do!).

The full source code is also here with heavy documentation throughout explaining some of my decisions and how I structured my code which I hope can help you with your own development.

I also wrote a number of tools to help me develop this game:

- Sprite, tiles, audio and bitmap tools: https://zx.remysharp.com
- txt2bas, bas2txt and validator: https://github.com/remy/txt2bas
- VS Code extension for NextBASIC: https://github.com/remy/vscode-nextbasic

I've also completed a devlog here: https://remysharp.com/devlog/go-mummy

---

For the OG version, I've used the [Internet Archive's copy of the Oh Mummy](https://archive.org/details/Oh_Mummy_1984_Amsoft) as reference.

- Sprites and tile maps created with my [ZX Sprite Tools](https://zx.remysharp.com/sprites/#tiles)
- Coded mostly in VS Code using my [NextBASIC VS Code extension](https://marketplace.visualstudio.com/items?itemName=remysharp.nextbasic)
- Dev previews in [Cspect](http://cspect.org/) then running hardware tests on my ZX Spectrum Next.

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
- [methods](https://github.com/remy/next-oh-mummy/blob/master/previous-attempts/methods.bas.txt) - `DEFPROC` code for working out when mummy's bumped into each other, but the cost of the function calls was [too high](https://remysharp.com/devlog/oh-mummy/2020-06-01) so it became all inline code

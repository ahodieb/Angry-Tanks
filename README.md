Angry Tanks
============

A tank shooting multiplayer video game presented as my microprocessor project. I published the game's source code so anyone can use it.

Developing Notes:
------------------
* The main game file is ['Game.c'][1] it has all the necessary code , the rest of files is generated / needed by the MicroC compiler. so if u just need to look at the code and logic around the game just look at this single file.

* The projectile model was approximated to a linear model for easier calculation on the controller. [curves have become triangles and no gravity equations were put into consideration]

  [1]: https://github.com/TheNightPhoenix/Angry-Tanks/blob/master/src/Game.c "Game.c"
  
Software Used:
----------------
* MikroC Pro http://www.mikroe.com/mikroc/pic/ [ there is a free version but i needed to use the builtin GLCD Libraries beacause i didnt have enough time for my project. ]
* Sadly the OS used is Windows cuz the burner i got doesn't support linux at least when i was developing this project.

Hardware Used:
----------------
* A GLCD (graphical LCD) 128 x 64.
* PIC Microcontroller (PIC 16F877A).
* 4 push buttons.
* a bunch of LEDs , Wires, Resistances and stuff.

* The basic hardware implementation is included in a pdf file.

Documentation:
---------------
i planned to have a full documentation for this project but i didn't have enough time and didn't feel that anyone will ever need it . but if u really want to use this project to help u somehow you can email me or contact me by any way and i'll be glad to help u as much as i can. 

Online Showcase:
-----------------

Youtube Video : http://www.youtube.com/watch?v=dvQp5y3ypOE

Photos of the project : http://www.flickr.com/photos/61552513@N02/sets/72157626900567375/

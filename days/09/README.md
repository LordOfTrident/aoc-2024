<h1 align="center">🎄 <a href="https://adventofcode.com/2023/day/9">Day 09</a></h1>
<p align="center">In <a href="https://harelang.org/">Hare</a></p>
<p align="center">
	<img src="https://harelang.org/mascot.png" width="50px">
</p>

First part seemed easy, but i stored the disk as a character array and assigned ASCII digits to file
chunks and for some reason did not realise there can be more than 9 files. I realised this very
quickly after the example passed but the actual input did not. As for part 2, i put together an
optimization-first implementation which again worked on the example, but not on the actual input.
I was sure the approach was correct because this day is quite simple. The code was a bit messy, so i
figured a bug managed to sneak in thanks to that, and i rewrote the code and cleaned it up (removing
some of the optimization). After that, it finally worked. I dont even know what the problem was in
the old code, but it doesnt matter. I got to try the Hare error system for the first time in part 2,
and i really like it. The multiple return type options and then matching them, a very nice approach.

I changed my mind on Hare a bit since i first tried it; i *probably will* use it for an actual
project, and its one of the best "C replacers" ive used so far. The only issue still is the lack of
platform support, but i guess i could use it for Linux/Unix-only CLI/TUI tools and stuff.

## Quickstart
To run part 1 or part 2, do:
```sh
$ make part1
$ make part2
```

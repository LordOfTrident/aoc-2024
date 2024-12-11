<h1 align="center">🎄 <a href="https://adventofcode.com/2023/day/11">Day 11</a></h1>
<p align="center">In <a href="https://c3-lang.org/">C3</a></p>
<p align="center">
	<img src="https://c3-lang.org/logo.svg" width="50px">
</p>

It was time to switch languages, and so i chose C3 because my friend Yeti suggested it. From todays
experience, it seems to me that C3 is really unfinished; the docs are lacking, the examples are
outdated and i even encountered a compiler bug on a thing as trivial as using `*=` on an array index
(`array[i] *= x`). Of course it is a very new and small language and bugs are expected, so im not
blaming anyone for that and i reported it as an issue to the C3 github repo. But the outdated
examples and poor docs are a real issue, it made it harder than it shouldve been for me to figure
out how to use some parts of the language (i couldnt figure out how the `LinkedList` structure is
supposed to be used, so i just implemented my own for part 1). The language also seems a bit dirty
syntactically with the macros and stuff, but its whatever i guess. Atleast they have method syntax,
so chaining is nice (unlike in Hare). Maybe i will change my opinion in the next few days, for the
better or worse. Will see. So far it was ok.

As for the actual task of the day, part 1 was pretty easy. I first did a quick implementation using
a regular dynamic array (saved that implementation in `part1.c3.bak`), which was obviously slow, so
i wanted to switch to a linked list. But as i mentioned, i couldnt figure out how to use the linked
list provided by C3 properly, so i implemented my own and it works fine. Part 2 on the other hand
was really annoying. I immediately realised that the order of stones does not matter and that i need
to do something with that fact, but for some reason i just didnt think of a real solution. I knew i
had to group them together somehow, but i didnt think of how. I can use excuses, like being tired
today because of waking up at 5:00 and having school until 15:05, but maybe im just dumb. I looked
up hints for solving it, and i found people talking about the exact same grouping approach, but they
also mentioned memoizing it with a hash map. I realised how simple that was to come up with after
you figure out that you need to group the stones together, and so im disappointed in myself that i
did not come up with the solution. I guess its just because i dont do any memoization tasks at all,
so it wasnt the first thing to come to my mind. I should practice AOC-like problems outside of AOC
throughout the year from time to time to get better at this stuff and get more problem solving
experience.

## Quickstart
To run part 1 or part 2, do:
```sh
$ make part1
$ make part2
```

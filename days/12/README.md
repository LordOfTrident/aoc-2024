<h1 align="center">🎄 <a href="https://adventofcode.com/2023/day/12">Day 12</a></h1>
<p align="center">In <a href="https://c3-lang.org/">C3</a></p>
<p align="center">
	<img src="https://c3-lang.org/logo.svg" width="50px">
</p>

A hard day. I got part 1 working relatively quickly after i realised how to approach this (flood
fill algorithm), but part 2 was pretty annoying. I eventually resorted to googling and found a hint
that the number of corners equals the number of sides. So i implemented code to count the number
of corners and got it working after a bit of bug fixing and playing around with offsets for the
corner checking. As for my opinion on C3, it hasnt really changed. I prefer Hare. One annoying thing
is having to pass `List` structures as pointers when modifying them, which causes some inconsistent
and ugly syntax. If i want to get the length of that list, i use `list.len()`. Now if i want to get
the `n`-th element, i have to do `(*list)[n]`. Im really not too fond of that. I would prefer if the
reference syntax thats present in `foreach` loops would also be a thing for function parameters,
like in C++.

I did not complete this day on 12th because i had to study for exams and did not have any time left
to do AOC, so im catching up today (13th).

## Quickstart
To run part 1 or part 2, do:
```sh
$ make part1
$ make part2
```

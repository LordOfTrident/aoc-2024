<h1 align="center">🎄 <a href="https://adventofcode.com/2023/day/3">Day 03</a></h1>
<p align="center">In <a href="https://www.rust-lang.org/">Rust</a></p>
<p align="center">
	<img src="https://raw.githubusercontent.com/devicons/devicon/55609aa5bd817ff167afce0d965585c92040787a/icons/rust/rust-plain.svg" width="50px">
</p>

This day was way easier than day 2. The only issue i ran into was with part 2, and that is not
because of the problem, but because of Rust. It was clear Regex would be really handy to solve part
2. But to use regex, i need to import the regex crate, which i can only easily do using cargo. That
means i had to drag a lot of bloat in and configure it to produce 2 executables. The end result
currently is kind of sloppy, but i made it work with the same makefile interface as all the other
days. But i dont like the noise and all those files and folders cargo brings in. Maybe there is a
way to avoid all that, i just didnt bother finding out how because i did not have much time today.
Maybe for the next days i will improve it and get back to this.

## Quickstart
To run part 1 or part 2, do:
```sh
$ make part1
$ make part2
```

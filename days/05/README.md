<h1 align="center">🎄 <a href="https://adventofcode.com/2023/day/5">Day 05</a></h1>
<p align="center">In <a href="https://www.rust-lang.org/">Rust</a></p>
<p align="center">
	<img src="https://raw.githubusercontent.com/devicons/devicon/55609aa5bd817ff167afce0d965585c92040787a/icons/rust/rust-plain.svg" width="50px">
</p>

This day was pretty easy, and i got to use a more interesting Rust data structure, `HashSet`. I have
used languages with built-in hash maps and sometimes i got into a situation where i needed to mark
which values i have seen somewhere. A hash map has fast access for that, but i need a value to store
in that, which is completely useless for this scenario, so i used to just use a simple bool value.
In C++ there is `std::set` and in Rust there is `HashSet`. The biggest struggle of this day for me
was actually parsing the input, i had to fight the compiler a bit to achieve that. For part 2 i
could not figure out how to check if the sort function changed the array at all, so i settled on
using `is_sorted_by` to check before sorting. This is a bit annoying because now i had to repeat
a similar lambda twice.

Edit:
I decided to change part 1 implementation to use the same `is_sorted_by` function as part 2 instead
of my own implementation. Makes the code shorter and probably faster. I commented out the old code.
This is also probably the last day of Rust for this year of AOC. I will switch to a different lang
and will soon consider using Rust for a project for the first time.

## Quickstart
To run part 1 or part 2, do:
```sh
$ make part1
$ make part2
```

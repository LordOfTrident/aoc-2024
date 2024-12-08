<h1 align="center">🎄 <a href="https://adventofcode.com/2023/day/7">Day 07</a></h1>
<p align="center">In <a href="https://harelang.org/">Hare</a></p>
<p align="center">
	<img src="https://harelang.org/mascot.png" width="50px">
</p>

This day was a relief. I picked Hare as the next language and i was praying that it would not be as
bad as V - it wasnt. It feels like a combination of C3 and Go (though i have never used C3, just
seen people use it and know the syntax roughly). The experience was smooth, until i used
`strconv::itos64` twice in a row. It converts an integer into a string. You would expect it to
return an allocated string that you then have to free, right? But no. It has an internal static
buffer into which it writes, and then it returns basically a pointer to that. So if you call the
function twice in a row, the second call overwrites the buffer and the result of the first call
becomes invalid. Admittedly, The documentation mentions it, but i did not read the function
description, only the signature, so i got stumped for a bit until i tracked down the bug and decided
to read the description. It is a very weird design choice. In C you would just pass a pointer to
your own allocated buffer to write into. I really wonder how this works with multithreading (if Hare
even supports that), because imagine 2 threads calling `strconv::itos64`. Other than that, the
language is pretty fine. Certainly nothing special, just like most "C replacers", but i can see
myself possibly using it for a small Linux project (there is no Windows support).

As for the day itself, it was just permutations. I actually had to look up how to generate
permutations, so this is the first day i had to look up something to solve the problem (other than
language docs). They made part 2 simpler than i would expect. My solution takes about a second to
run, but to me that is good enough.

## Quickstart
To run part 1 or part 2, do:
```sh
$ make part1
$ make part2
```

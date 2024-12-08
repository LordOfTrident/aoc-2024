<h1 align="center">🎄 <a href="https://adventofcode.com/2023/day/8">Day 08</a></h1>
<p align="center">In <a href="https://harelang.org/">Hare</a></p>
<p align="center">
	<img src="https://harelang.org/mascot.png" width="50px">
</p>

This day was easy. Day 7 was about permutations, and now day 8 was about combinations, which are
easier. I also had no problems doing this day in Hare, its a pretty fine and nice language. I still
think the syntax could use a little less noise (its noisier than Rust), but its otherwise a pretty
good "C replacer". I will use it for a few more days. The only "issue" was that Hare does not have
hash maps, which would come in handy for this day (for assigning groups of antennas to frequencies).
But it was not that big of an issue, since the frequencies are just ASCII characters, so i just used
a static array of 128 elements which i index by the frequency. Exactly like i would solve this in C.

## Quickstart
To run part 1 or part 2, do:
```sh
$ make part1
$ make part2
```

<h1 align="center">🎄 <a href="https://adventofcode.com/2023/day/13">Day 13</a></h1>
<p align="center">In <a href="https://c3-lang.org/">C3</a></p>
<p align="center">
	<img src="https://c3-lang.org/logo.svg" width="50px">
</p>

Another day, another googling session. AOC is getting too hard for me to be able to come up with
real solutions now. I looked up hints again and found out i had to apply [Cramer's rule](https://en.wikipedia.org/wiki/Cramer%27s_rule)
(gotta love when the solution to an AOC problem is some math thing from wikipedia ive never heard of).
This solution works the same for both part 1 and 2, so the code doesnt change apart from adding
`10000000000000` to the prize position in part 2. I feel really dumb not being able to solve these,
day 13 feels really low (even though its halfway through) and im kinda disappointed in myself. But
realistically, i cant expect to be able to do this since i dont have the math skill or experience to
know about these rules and stuff. Im gonna *try* to do more of these AOC-style problems outside of
AOC to get some of that experience.

And now about C3. Today was a little more involved when it comes to parsing the input, and it went
way better than i expected in C3. It was actually pretty easy to get the parsing going, which is
nice. I appreciate C3 for the convenient string manipulation functions that you can easily chain.
This is where C3 takes the cake over Hare, where string manipulation gets kinda painful, like in C.

## Quickstart
To run part 1 or part 2, do:
```sh
$ make part1
$ make part2
```

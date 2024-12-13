module part2;
import std::io;
import std::math;
import std::collections::map;
import std::collections::list;

def Stones = HashMap(<usz, usz>);

fn void add(Stones *stones, usz n, usz count) {
	if (stones.has_key(n)) {
		stones.set(n, stones.get(n)!! + count);
	} else {
		stones.set(n, count);
	}
}

fn Stones read_input() {
	String[] parts = ((String)io::file::load_new("input.txt")!!).strip_end("\n").split(" ");
	Stones   stones;
	stones.new_init();
	foreach (part : parts)
		add(&stones, part.to_integer(usz)!!, 1);
	return stones;
}

fn int count_digits(usz n) {
	int count = 0;
	while (n > 0) {
		n /= 10;
		++ count;
	}
	return count;
}

fn Stones blink(Stones stones) {
	Stones next;
	next.new_init();

	stones.@each(; usz stone, usz count) {
		int digits;
		if (stone == 0) {
			add(&next, 1, count);
		} else if ((digits = count_digits(stone)) % 2 == 0) {
			usz half  = (usz)math::pow(10, digits / 2);
			usz left  = stone / half;
			usz right = stone - left * half;

			add(&next, left, count);
			add(&next, right, count);
		} else {
			add(&next, stone * 2024, count);
		}
	};

	return next;
}

fn void main() {
	Stones stones = read_input();
	for (usz i = 0; i < 75; ++ i)
		stones = blink(stones);

	usz total = 0;
	stones.@each(; usz stone, usz count) {
		total += count;
	};
	io::printn(total);
}

module hello_world;
import std::io;
import std::collections::linkedlist;
import std::math;

struct Stone {
	usz count, n;
	Stone* next;
}

fn Stone* new_stone(usz n) {
	Stone* stone = mem::new(Stone);
	stone.count  = 0;
	stone.n      = n;
	stone.next   = null;
	return stone;
}

fn Stone *read_input() {
	String[] parts  = ((String)io::file::load_new("input.txt")!!).strip_end("\n").split(" ");
	Stone*   stones = null;
	Stone*   last;
	foreach (part : parts) {
		Stone *stone = new_stone(part.to_integer(usz)!!);

		if (stones == null) {
			stones = stone;
		} else {
			last.next = stone;
		}

		last = stone;
	}
	stones.count = parts.len;
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

fn void blink(Stone* stones) {
	Stone* stone = stones;
	while (stone != null) {
		Stone* next = stone.next;

		int digits;
		if (stone.n == 0) {
			stone.n = 1;
		} else if ((digits = count_digits(stone.n)) % 2 == 0) {
			usz half  = (usz)math::pow(10, digits / 2);
			usz left  = stone.n / half;
			usz right = stone.n - left * half;

			stone.n    = left;
			Stone* tmp = new_stone(right);
			tmp.next   = stone.next;
			stone.next = tmp;
			++ stones.count;
		} else {
			stone.n *= 2024;
		}

		stone = next;
	}
}

fn void main() {
	Stone* stones = read_input();
	for (usz i = 0; i < 25; ++ i)
		blink(stones);

	io::printn(stones.count);
}

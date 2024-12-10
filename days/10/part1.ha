use fmt;
use io;
use os;
use strings;

fn read_map() [][]int = {
	const file = os::open("input.txt")!;
	defer io::close(file)!;
	const lines = strings::split(strings::fromutf8(io::drain(file)!)!, "\n");

	let rows: [][]int = [];
	for (const line .. lines) {
		if (len(line) == 0)
			continue;

		let row: []int = [];
		for (const ch .. strings::toutf8(line))
			append(row, (ch - '0'): int);

		append(rows, row);
	};
	return rows;
};

fn step(map: [][]int, sx: int, sy: int) int = {
	const dirs = [[-1, 0], [0, -1], [1, 0], [0, 1]]; // Left, up, right, down
	const next = -map[sy][sx] + 1;
	let   sum  = 0;
	for (const dir .. dirs) {
		// Find next position
		let x = sx + dir[0];
		let y = sy + dir[1];
		if (x < 0 || x >= len(map[0]): int || y < 0 || y >= len(map): int)
			continue;
		if (map[y][x] != next) // Check if the height matches the next expected height
			continue;

		map[y][x] *= -1; // Mark it as seen

		if (map[y][x] == -9) // Check if it is the end
			sum += 1
		else
			sum += step(map, x, y);
	};
	return sum;
};

fn clean_map(map: [][]int) void = {
	// Remove all "seen" markings
	for (let y = 0z; y < len(map); y += 1) {
		for (let x = 0z; x < len(map[0]); x += 1) {
			if (map[y][x] < 0)
				map[y][x] *= -1;
		};
	};
};

export fn main() void = {
	const map = read_map();
	let   sum = 0;
	for (let y = 0z; y < len(map); y += 1) {
		for (let x = 0z; x < len(map[0]); x += 1) {
			if (map[y][x] == 0) {
				sum += step(map, x: int, y: int);
				clean_map(map);
			};
		};
	};
	fmt::printfln("{}", sum)!;
};

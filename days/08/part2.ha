use fmt;
use io;
use os;
use strings;

fn read_map() [][]u8 = {
	const file = os::open("input.txt")!;
	defer io::close(file)!;
	const lines = strings::split(strings::fromutf8(io::drain(file)!)!, "\n");

	let rows: [][]u8 = [];
	for (const line .. lines) {
		if (len(line) == 0)
			continue;

		append(rows, strings::toutf8(line));
	};
	return rows;
};

type antenna = struct {
	x: int,
	y: int,
};

type antennas = struct {
	groups: [128][]antenna,
};

fn extract_antennas(map: [][]u8) antennas = {
	let antennas = antennas{...};
	for (let y = 0z; y < len(map); y += 1) {
		for (let x = 0z; x < len(map[0]); x += 1) {
			if (map[y][x] == '.')
				continue;

			append(antennas.groups[map[y][x]], antenna{x = x: int, y = y: int});
		};
	};
	return antennas;
};

fn is_in_bounds(map: [][]u8, x: int, y: int) bool = {
	return x >= 0 && x < (len(map[0]): int) && y >= 0 && y < (len(map): int);
};

fn antinode_line(map: [][]u8, x: int, y: int, sx: int, sy: int) int = {
	let sum = 0;
	for (is_in_bounds(map, x, y)) {
		if (map[y][x] != '#') {
			map[y][x] = '#';
			sum      += 1;
		};
		x += sx;
		y += sy;
	};
	return sum;
};

fn test_pair(map: [][]u8, a: antenna, b: antenna) int = {
	let dx  = (b.x - a.x);
	let dy  = (b.y - a.y);
	return antinode_line(map, a.x, a.y, -dx, -dy) + antinode_line(map, b.x, b.y, dx, dy);
};

fn test_combos(map: [][]u8, group: []antenna) int = {
	let sum = 0;
	for (let i = 0z; i < len(group); i += 1) {
		for (let j = i + 1; j < len(group); j += 1)
			sum += test_pair(map, group[i], group[j]);
	};
	return sum;
};

export fn main() void = {
	const map      = read_map();
	const antennas = extract_antennas(map);

	let sum = 0;
	for (const group .. antennas.groups) {
		if (len(group) == 0)
			continue;

		sum += test_combos(map, group);
	};
	fmt::printfln("{}", sum)!;
};

use fmt;
use io;
use os;
use strings;

fn read_disk() []int = {
	const file = os::open("input.txt")!;
	defer io::close(file)!;
	const line = strings::toutf8(strings::split(strings::fromutf8(io::drain(file)!)!, "\n")[0]);

	let disk: []int = [];
	for (let i = 0z; i < len(line); i += 1) {
		for (let j = 0; j < (line[i] - '0'): int; j += 1)
			append(disk, if (i % 2 == 0) (i / 2): int else -1);
	};
	return disk;
};

fn move_chunk(disk: []int, from: size, to: size, sz: size) void = {
	for (let i = 0z; i < sz; i += 1) {
		disk[to   + i] = disk[from + i];
		disk[from + i] = -1;
	};
};

fn find_free_chunk(disk: []int, end: size, sz: size) (size | void) = {
	let collected = 0z;
	for (let i = 0z; i < end; i += 1) {
		if (disk[i] >= 0) {
			collected = 0;
			continue;
		};

		collected += 1;
		if (collected >= sz)
			return i - collected + 1;
	};
};

fn perform_compacting(disk: []int) void = {
	for (let i = len(disk) - 1; i > 0; i -= 1) {
		if (disk[i] < 0)
			continue;

		let sz = 0z;
		for (disk[i - sz] == disk[i] && i - sz > 0)
			sz += 1;

		i -= sz - 1;
		match (find_free_chunk(disk, i, sz)) {
		case let pos: size => move_chunk(disk, i, pos, sz);
		case void          => continue;
		};
	};
};

fn checksum(disk: []int) size = {
	let sum = 0z;
	for (let i = 0z; i < len(disk); i += 1) {
		if (disk[i] >= 0)
			sum += disk[i]: size * i;
	};
	return sum;
};

export fn main() void = {
	const disk = read_disk();
	perform_compacting(disk);
	fmt::printfln("{}", checksum(disk))!;
};

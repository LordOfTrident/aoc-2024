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

fn perform_compacting_and_checksum(disk: []int) size = {
	let next = 0z;
	let sum  = 0z;
	for (let i = len(disk) - 1; next < i; i -= 1) {
		if (disk[i] < 0)
			continue;

		for (next < i) {
			if (disk[next] < 0) {
				disk[next] = disk[i];
				disk[i]    = -1;
				break;
			};

			sum  += disk[next]: size * next;
			next += 1;
		};
	};
	sum += disk[next]: size * next;
	return sum;
};

export fn main() void = {
	const disk = read_disk();
	fmt::printfln("{}", perform_compacting_and_checksum(disk))!;
};

use fmt;
use io;
use os;
use strings;
use strconv;

type equation = struct {
	test: i64,
	nums: []i64,
};

fn read_input() []equation = {
	const file = os::open("input.txt")!;
	defer io::close(file)!;
	const lines = strings::split(strings::fromutf8(io::drain(file)!)!, "\n");

	let equations: []equation = [];
	for (const line .. lines) {
		if (len(line) == 0)
			continue;

		const parts = strings::split(line, " ");
		let equation = equation{
			test = strconv::stoi64(strings::sub(parts[0], 0, len(parts[0]) - 1))!,
			nums = []
		};

		for (let i = 1z; i < len(parts); i += 1)
			append(equation.nums, strconv::stoi64(parts[i])!);

		append(equations, equation);
	};
	return equations;
};

type op = enum {
	ADD,
	MUL,
	CONCAT,
};

const ops = [op::ADD, op::MUL, op::CONCAT];

fn concat_nums(a: i64, b: i64) i64 = {
	let tmp   = b;
	let count = 1i64;
	for (tmp > 0) {
		tmp   /= 10;
		count *= 10;
	};
	return a * count + b;
};

// Possible optimization: If the test is greater than the product of all numbers, you can exit early
fn permute_ops(equation: equation, into: []op, i: size) bool = {
	if (i == len(into)) {
		let sum = equation.nums[0];
		for (let i = 0z; i < len(into); i += 1) {
			switch (into[i]) {
			case op::ADD    => sum += equation.nums[i + 1];
			case op::MUL    => sum *= equation.nums[i + 1];
			case op::CONCAT => sum  = concat_nums(sum, equation.nums[i + 1]);
			};
		};

		return sum == equation.test;
	};

	for (let j = 0z; j < len(ops); j += 1) {
		into[i] = ops[j];
		if (permute_ops(equation, into, i + 1))
			return true;
	};

	return false;
};

export fn main() void = {
	const equations = read_input();

	let sum = 0i64;
	for (const equation .. equations) {
		let ops: []op = [];
		defer free(ops);
		for (let i = 1z; i < len(equation.nums); i += 1)
			append(ops, op::ADD);

		if (permute_ops(equation, ops, 0))
			sum += equation.test;
	};
	fmt::printfln("{}", sum)!;
};

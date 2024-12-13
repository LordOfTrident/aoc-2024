module part2;
import std::io;
import std::math;
import std::collections::list;

struct Machine {
	usz[2] a, b, prize;
}

def Machines = List(<Machine>);

fn usz parse(String s, String prefix, String postfix) {
	return s[s.index_of(prefix)!! + prefix.len ..].split(postfix)[0].to_integer(usz)!!;
}

fn Machines read_input() {
	Machines machines;
	machines.new_init();

	foreach (part : ((String)io::file::load_new("input.txt")!!).strip_end("\n").split("\n\n")) {
		String[] lines = part.split("\n");
		String   line;
		Machine  machine;
		machine.a[0]     = parse(lines[0], "X+", ",");
		machine.a[1]     = parse(lines[0], "Y+", ",");
		machine.b[0]     = parse(lines[1], "X+", ",");
		machine.b[1]     = parse(lines[1], "Y+", ",");
		machine.prize[0] = parse(lines[2], "X=", ",") + 10000000000000;
		machine.prize[1] = parse(lines[2], "Y=", ",") + 10000000000000;
		machines.push(machine);
	}
	return machines;
}

fn void main() {
	Machines machines = read_input();

	usz sum = 0;
	foreach (m : machines) {
		// https://en.wikipedia.org/wiki/Cramer%27s_rule
		// xi = det(Ai) / det(A)
		// a11 * x1 + a12 * x2 = b1
		// a21 * x1 + a22 * x2 = b2
		usz det_a  = math::abs(m.a[0]     * m.b[1]     - m.a[1]     * m.b[0]);
		usz det_a1 = math::abs(m.prize[0] * m.b[1]     - m.prize[1] * m.b[0]);
		usz det_a2 = math::abs(m.a[0]     * m.prize[1] - m.a[1]     * m.prize[0]);
		if (det_a1 % det_a == 0 && det_a2 % det_a == 0) {
			sum += det_a1 / det_a * 3 + det_a2 / det_a;
		}
		continue;
	}
	io::printn(sum);
}

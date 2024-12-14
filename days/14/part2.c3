module part1;
import std::io;
import std::collections::list;

struct Robot {
	int[2] p, v;
}

def Robots = List(<Robot>);
def Map    = int[101][103];

fn int[2] parse(String s, String prefix) {
	String[] parts = s[s.index_of(prefix)!! + prefix.len ..].split(",");
	return {parts[0].to_integer(int)!!, parts[1].split(" ")[0].to_integer(int)!!};
}

fn Robots read_input() {
	Robots robots;
	robots.new_init();

	foreach (line : ((String)io::file::load_new("input.txt")!!).strip_end("\n").split("\n")) {
		Robot robot;
		robot.p     = parse(line, "p=");
		robot.v     = parse(line, "v=");
		robots.push(robot);
	}
	return robots;
}

fn bool contains_horizontal_line(Map map, int len) {
	int counter = 0;
	foreach (row : map) {
		int prev = 0;
		foreach (tile : row) {
			++ counter;
			if (tile == 0 || prev == 0) counter = 0;

			if (counter == len) return true;
			prev = tile;
		}
	}
	return false;
}

fn void Robot.move(&self, Map* map) {
	int* tile = &(*map)[self.p[1]][self.p[0]];
	if (*tile > 0) -- *tile;

	self.p[0] = (self.p[0] + self.v[0]) % (int)(*map)[0].len;
	self.p[1] = (self.p[1] + self.v[1]) % (int)(*map).len;

	while (self.p[0] < 0) self.p[0] += (*map)[0].len;
	while (self.p[1] < 0) self.p[1] += (*map).len;

	tile = &(*map)[self.p[1]][self.p[0]];
	++ *tile;
}

fn void main() {
	Robots robots = read_input();
	Map    map;
	usz    second = 0;
	do {
		++ second;
		foreach (&r : robots) r.move(&map);
	} while (!contains_horizontal_line(map, 10));

	io::printn(second);
}

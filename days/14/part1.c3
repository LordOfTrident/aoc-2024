module part1;
import std::io;
import std::collections::list;

struct Robot {
	int[2] p, v;
}

def Robots = List(<Robot>);

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

fn void Robot.move(&self, int w, int h) {
	self.p[0] = (self.p[0] + self.v[0]) % w;
	self.p[1] = (self.p[1] + self.v[1]) % h;

	while (self.p[0] < 0) self.p[0] += w;
	while (self.p[1] < 0) self.p[1] += h;
}

fn bool pos_in_rect(int[2] pos, int[4] rect) {
	return pos[0] >= rect[0] && pos[1] >= rect[1] && pos[0] <= rect[2] && pos[1] <= rect[3];
}

fn void count_robots_in_quadrants(Robots robots, int[4]* quadrants, int w, int h) {
	int cx = w / 2;
	int cy = h / 2;

	int[4][*] quadrant_rects = {
		{0,      0,      cx - 1, cy - 1},
		{cx + 1, 0,      w  - 1, cy - 1},
		{0,      cy + 1, cx - 1, h  - 1},
		{cx + 1, cy + 1, w  - 1, h  - 1},
	};

	foreach (robot : robots) {
		foreach (i, rect : quadrant_rects) {
			if (pos_in_rect(robot.p, rect)) {
				++ (*quadrants)[i];
				break;
			}
		}
	}
}

fn void main() {
	int w = 101;
	int h = 103;

	Robots robots = read_input();

	for (int i = 0; i < 100; ++ i) foreach (&r : robots) r.move(w, h);

	int[4] quadrants;
	count_robots_in_quadrants(robots, &quadrants, w, h);

	usz sum = 1;
	foreach (quadrant : quadrants) sum *= quadrant;
	io::printn(sum);
}

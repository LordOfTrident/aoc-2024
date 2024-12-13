module part2;
import std::io;
import std::collections::list;
import std::collections::map;

def Row  = List(<int>);
def Grid = List(<Row>);

fn String[] read_input() {
	return ((String)io::file::load_new("input.txt")!!).strip_end("\n").split("\n");
}

fn Grid create_grid(usz w, usz h) {
	Grid grid;
	grid.new_init(h);
	for (usz y = 0; y < h; ++ y) {
		Row row;
		row.new_init(w);
		for (usz x = 0; x < w; ++ x) {
			row.push(0);
		}
		grid.push(row);
	}
	return grid;
}

fn bool is_in_region(String[] lines, char ch, int x, int y) {
	return x >= 0 && x < lines[0].len && y >= 0 && y < lines.len && lines[y][x] == ch;
}

fn usz count_corners(String[] lines, char ch, int sx, int sy) {
	// Offsets for both inner and outer corner checks, packed in one array
    int[*][*][*] variants = {
        {{ 0, -1}, { 1, 0}, { 1, -1}},
        {{ 0, -1}, {-1, 0}, {-1, -1}},
        {{ 1,  0}, { 0, 1}, { 1,  1}},
        {{-1,  0}, { 0, 1}, {-1,  1}},
    };

	usz sum = 0;
    foreach (os : variants) {
    	// Inner corner check
    	if (!is_in_region(lines, ch, sx + os[0][0], sy + os[0][1]) &&
    	    !is_in_region(lines, ch, sx + os[1][0], sy + os[1][1])) ++ sum;

		// Outer corner check
    	if (is_in_region(lines, ch, sx + os[0][0], sy + os[0][1]) &&
    	    is_in_region(lines, ch, sx + os[1][0], sy + os[1][1]) &&
    	   !is_in_region(lines, ch, sx + os[2][0], sy + os[2][1])) ++ sum;
    }
    return sum;
}

fn void flood_fill(String[] lines, Grid* grid, usz* area, usz* sides,
                   int id, char ch, int sx, int sy) {
	if (sx < 0 || sx >= lines[0].len || sy < 0 || sy >= lines.len ||
	    lines[sy][sx] != ch || (*grid)[sy][sx] != 0) return;

	(*grid)[sy][sx] = id;
	++ *area;
	*sides += count_corners(lines, ch, sx, sy);

	int[*][*] dirs = {{-1, 0}, {0, -1}, {1, 0}, {0, 1}};
	foreach (dir : dirs) {
		int x = sx + dir[0];
		int y = sy + dir[1];
		flood_fill(lines, grid, area, sides, id, ch, x, y);
	}
}

fn void main() {
	String[] lines = read_input();
	Grid     grid  = create_grid(lines[0].len, lines.len);

	int next_id = 1;
	usz sum     = 0;
	for (usz y = 0; y < lines.len; ++ y) {
		for (usz x = 0; x < lines[0].len; ++ x) {
			if (grid[y][x] != 0) continue;

			usz area, sides;
			flood_fill(lines, &grid, &area, &sides, next_id ++, lines[y][x], (int)x, (int)y);
			sum += area * sides;
		}
	}
	io::printn(sum);
}

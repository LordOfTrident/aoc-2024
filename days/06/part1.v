import os

fn read_map() [][]u8 {
	mut my_map := [][]u8{len: 0}
	for line in os.read_lines("input.txt") or {panic("Failed to read input")} {
		mut row := []u8{len: 0}
		for ch in line {
			row << ch
		}
		my_map << row
	}
	return my_map
}

// V has no global variables (yikes), so im using functions as a workaround (i know globals can be
// enabled through compiler flags but i dont like that)
fn dir_to_ch(dir int) u8 {
	return [`^`, `>`, `v`, `<`][dir]
}

fn ch_to_dir(ch u8) int {
	return {`^`: 0, `>`: 1, `v`: 2, `<`: 3}[ch]
}

fn turn(ch u8) u8 {
	dir := ch_to_dir(ch) + 1
	return dir_to_ch(if dir >= 4 {0} else {dir})
}

fn find_guard(my_map [][]u8) (int, int) {
	mut gx, mut gy := 0, 0
	for y, row in my_map {
		for x, tile in row {
			if tile == `^` || tile == `>`|| tile == `v` || tile == `<` {
				gx, gy = x, y
				break
			}
		}
	}

	return gx, gy
}

fn not_in_area(my_map [][]u8, x int, y int) bool {
	return x < 0 || x >= my_map[0].len || y < 0 || y >= my_map.len
}

fn can_move_to(my_map [][]u8, x int, y int) bool {
	return my_map[y][x] == `.` || my_map[y][x] == `X`
}

fn move_guard(mut my_map [][]u8, gx int, gy int) (int, int, bool) {
	ch   := my_map[gy][gx]
	off  := [[0, -1], [1, 0], [0, 1], [-1, 0]][ch_to_dir(ch)]
	x, y := gx + off[0], gy + off[1]

	if not_in_area(my_map, x, y) {
		my_map[gy][gx] = `X`
		return x, y, true
	} else if !can_move_to(my_map, x, y) {
		my_map[gy][gx] = turn(ch)
		return gx, gy, false
	}

	my_map[gy][gx] = `X`
	my_map[y][x]   = ch
	return x, y, false
}

fn main() {
	mut my_map := read_map()
	mut gx, mut gy := find_guard(my_map)

	mut left_area := false
	for !left_area {
		gx, gy, left_area = move_guard(mut &my_map, gx, gy)
	}

	mut sum := 0
	for row in my_map {
		for tile in row {
			if tile == `X` {
				sum ++
			}
		}
	}
	println("$sum")
}

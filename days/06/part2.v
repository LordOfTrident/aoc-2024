// =========================================================
// ========== Abandon all hope ye who enter here. ==========
// =========================================================

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

fn dir_to_off(dir int) []int {
	return [[0, -1], [1, 0], [0, 1], [-1, 0]][dir]
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
	mut ch       := my_map[gy][gx]
	mut off      := dir_to_off(ch_to_dir(ch))
	mut x, mut y := gx + off[0], gy + off[1]

	if not_in_area(my_map, x, y) {
		my_map[gy][gx] = `X`
		return x, y, true
	} else if !can_move_to(my_map, x, y) {
		for !can_move_to(my_map, x, y) {
			ch             = turn(ch)
			my_map[gy][gx] = ch
			off            = dir_to_off(ch_to_dir(ch))
			x, y           = gx + off[0], gy + off[1]
		}
		return gx, gy, false
	}

	my_map[gy][gx] = `X`
	my_map[y][x]   = ch
	return x, y, false
}

fn mark_walked(mut my_map [][]u8, sx int, sy int) {
	mut gx, mut gy := sx, sy
	mut left_area  := false
	for !left_area {
		gx, gy, left_area = move_guard(mut &my_map, gx, gy)
	}
}

fn try_loop_at(mut my_map [][]u8, ox int, oy int, sx int, sy int) bool {
	mut visited := [][]int{len: 0}

	my_map[oy][ox] = `#`

	mut gx, mut gy := sx, sy
	mut left_area  := false
	for {
		gx, gy, left_area = move_guard(mut &my_map, gx, gy)
		if left_area {
			break
		}

		dir := ch_to_dir(my_map[gy][gx])
		mut over := false
		for info in visited {
			lx, ly, ldir := info[0], info[1], info[2]
			if lx == gx && ly == gy && ldir == dir {
				over = true
				break
			}
		}
		if over {
			break
		}

		visited << [gx, gy, dir]
	}

	if !left_area {
		my_map[gy][gx] = `X`
	}
	my_map[oy][ox] = `X`
	return !left_area
}

fn main() {
	mut my_map := read_map()
	sx, sy := find_guard(my_map)
	ch     := my_map[sy][sx]
	mark_walked(mut &my_map, sx, sy)

	mut sum := 0
	for y, row in my_map {
		for x, tile in row {
			if tile != `X` || (y == sy && x == sx) {
				continue
			}

			mut map_copy := my_map.clone()
			map_copy[sy][sx] = ch
			if try_loop_at(mut &map_copy, x, y, sx, sy) {
				sum ++
			}
		}
	}
	println("$sum")
}

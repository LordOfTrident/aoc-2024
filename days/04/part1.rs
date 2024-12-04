use std::fs::read_to_string;

fn read_board() -> Vec<Vec<u8>> {
	read_to_string("input.txt")
		.unwrap()
		.lines()
		.map(|s| s.bytes().collect())
		.collect()
}

fn try_match_at_offset(board: &Vec<Vec<u8>>, pos: &Point, dir: &Point) -> bool {
	let to_match = "XMAS";
	for (i, ch) in to_match.chars().enumerate() {
		let x = pos.x + dir.x * i as i32;
		let y = pos.y + dir.y * i as i32;

		if x < 0 || y < 0 || x >= (board[0].len() as i32) || y >= (board.len() as i32) ||
		   board[y as usize][x as usize] as char != ch {
			return false;
		}
	}
	return true;
}

struct Point {
	x: i32, y: i32
}

fn count_8_way_matches(board: &Vec<Vec<u8>>, pos: &Point) -> i32 {
	if board[pos.y as usize][pos.x as usize] != b'X' {
		return 0;
	}

	let dirs: &[Point] = &[
		Point{x: -1, y: -1},
		Point{x:  0, y: -1},
		Point{x:  1, y: -1},
		Point{x:  1, y:  0},
		Point{x:  1, y:  1},
		Point{x:  0, y:  1},
		Point{x: -1, y:  1},
		Point{x: -1, y:  0},
	];

	let mut count = 0;
	for dir in dirs {
		if try_match_at_offset(board, pos, dir) {
			count += 1;
		}
	}
	return count;
}

fn main() {
	let board   = read_board();
	let mut sum = 0;
	for y in 0 .. board.len() {
		for x in 0 .. board[y].len() {
			sum += count_8_way_matches(&board, &Point{x: x as i32, y: y as i32});
		}
	}

	println!("{}", sum);
}

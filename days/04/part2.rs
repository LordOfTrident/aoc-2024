use std::fs::read_to_string;

fn read_board() -> Vec<Vec<u8>> {
	read_to_string("input.txt")
		.unwrap()
		.lines()
		.map(|s| s.bytes().collect())
		.collect()
}

fn try_match_at_offset(board: &Vec<Vec<u8>>, pos: &Point, dir: &Point) -> bool {
	let to_match = "MAS";
	for (i, ch) in to_match.chars().enumerate() {
		let n = to_match.len() as i32 / 2 - i as i32;
		let x = pos.x + dir.x * n;
		let y = pos.y + dir.y * n;

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

fn is_x_mas(board: &Vec<Vec<u8>>, pos: &Point) -> bool {
	if board[pos.y as usize][pos.x as usize] != b'A' {
		return false;
	}

	return (try_match_at_offset(board, pos, &Point{x: -1, y: -1})  ||
	        try_match_at_offset(board, pos, &Point{x:  1, y:  1})) &&
	       (try_match_at_offset(board, pos, &Point{x:  1, y: -1})  ||
	        try_match_at_offset(board, pos, &Point{x: -1, y:  1}))
}

fn main() {
	let board   = read_board();
	let mut sum = 0;
	for y in 0 .. board.len() {
		for x in 0 .. board[y].len() {
			if is_x_mas(&board, &Point{x: x as i32, y: y as i32}) {
				sum += 1;
			}
		}
	}

	println!("{}", sum);
}

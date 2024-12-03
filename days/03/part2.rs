use std::fs::read_to_string;
use regex::Regex;

fn main() {
	let mem         = read_to_string("input.txt").unwrap();
	let re          = Regex::new(r"mul\((\d+),(\d+)\)|do\(\)|don't\(\)").unwrap();
	let mut sum     = 0;
	let mut enabled = true;
	for cap in re.captures_iter(&mem) {
		match &cap[0] {
			"do()"    => enabled = true,
			"don't()" => enabled = false,
			_ => if enabled {
				sum += cap[1].parse::<i32>().unwrap() * cap[2].parse::<i32>().unwrap();
			}
		}
	}

	println!("{}", sum);
}

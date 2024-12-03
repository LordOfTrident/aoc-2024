use std::fs::read_to_string;

fn eval_mul(s: &str) -> Option<i32> {
	let args: Vec<_> = s[s.find("(")? + 1 .. s.find(")")?]
		.split(",")
		.map(|e| e.parse::<i32>())
		.collect();
	if args.len() != 2 {
		return None;
	}

	return Some(args[0].as_ref().ok()? * args[1].as_ref().ok()?);
}

fn main() {
	let mem     = read_to_string("input.txt").unwrap();
	let mut sum = 0;
	for (i, _) in mem.match_indices("mul(") {
		let n = eval_mul(&mem[i ..]);
		if n.is_some() {
			sum += n.unwrap();
		}
	}

	println!("{}", sum);
}

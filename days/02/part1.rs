use std::fs::read_to_string;

fn read_reports() -> Vec<Vec<i32>> {
	read_to_string("input.txt")
		.unwrap()
		.lines()
		.map(|line| line // Not sure how to format this in a readable way, i guess this is fine
			.split(" ")
			.map(|num| num
				.parse()
				.unwrap()
			).collect()
		).collect()
}

fn is_report_safe(report: Vec<i32>) -> bool {
	let mut prev_sum = 0;
	for i in 1 .. report.len() { // Is there no iter magic to use for this instead?
		let sum = report[i] - report[i - 1];
		if sum == 0 || sum.abs() > 3 || (prev_sum != 0 && sum.cmp(&0) != prev_sum.cmp(&0)) {
			return false;
		}

		prev_sum = sum;
	}
	return true;
}

fn main() {
	let mut count = 0;
	let reports = read_reports();
	for report in reports {
		if is_report_safe(report) {
			count += 1;
		}
	}

	println!("{}", count);
}

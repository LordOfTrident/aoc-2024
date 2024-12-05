use std::fs::read_to_string;
use std::collections::HashSet;
use std::cmp::Ordering;

type Rule   = (i32, i32);
type Update = Vec<i32>;

fn parse_rules(s: &str) -> HashSet<Rule> {
	let mut rules = HashSet::<Rule>::new();
	s
		.lines()
		.filter_map(|line| line
			.split_once('|')
			.map(|(a, b)| (a.parse().unwrap(), b.parse().unwrap()))
		).for_each(|pair| {rules.insert(pair);});

	return rules;
}

fn parse_updates(s: &str) -> Vec<Update> {
	s
		.lines()
		.map(|line| line
			.split(",")
			.map(|num| num
				.parse()
				.unwrap()
			).collect()
		).collect()
}

fn read_page_data() -> (HashSet<Rule>, Vec<Update>) {
	let binding = read_to_string("input.txt").unwrap();
	let parts: Vec<&str> = binding
		.split("\n\n")
		.collect();
	return (parse_rules(parts[0]), parse_updates(parts[1]));
}

fn main() {
	let (rules, updates) = read_page_data();
	let mut sum = 0;
	for mut update in updates {
		if !update.is_sorted_by(|a, b| rules.contains(&(*a, *b))) {
			update.sort_by(|a, b|
				if rules.contains(&(*a, *b)) {Ordering::Less} else {Ordering::Greater}
			);
			sum += update[update.len() / 2];
		}
	}

	println!("{}", sum);
}

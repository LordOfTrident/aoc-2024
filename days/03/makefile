all:
	@echo part1, part2, clean

part1: ./target/debug/part1
	@./target/debug/part1

part2: ./target/debug/part2
	@./target/debug/part2

target/debug/part1: part1.rs
	@cargo build

target/debug/part2: part2.rs
	@cargo build

clean:
	rm -f -r target

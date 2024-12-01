all:
	@echo part1, part2, clean

part1: part1.out
	@./part1.out

part2: part2.out
	@./part2.out

%.out: %.c
	@$(CC) -Wall -Wextra -Werror -pedantic $< -o $@

clean:
	rm -f part1.out part2.out

#include <stdio.h>   /* printf, fopen, fclose, fgetc, fgets, rewind */
#include <stdlib.h>  /* malloc, free */
#include <string.h>  /* strtok */
#include <stdbool.h> /* bool, true, false */
#include <math.h>    /* abs */
#include <assert.h>  /* assert */

int CountLines(FILE *file) {
	int ch, count = 0;
	while ((ch = fgetc(file)) != EOF) {
		if (ch == '\n')
			++ count;
	}
	rewind(file);
	return count;
}

int ReadLists(int **as, int **bs) {
	FILE *file = fopen("input.txt", "r");
	assert(file != NULL);

	int count = CountLines(file);
	*as = malloc(count * sizeof(*as));
	*bs = malloc(count * sizeof(*bs));
	assert(*as != NULL && *bs != NULL);

	char line[64];
	for (int i = 0; fgets(line, sizeof(line), file) != NULL; ++ i) {
		(*as)[i] = atoi(strtok(line, " "));
		(*bs)[i] = atoi(strtok(NULL, " "));
	}

	fclose(file);
	return count;
}

void BubbleSort(int *xs, int count) {
	bool swapped;
	do {
		swapped = false;
		for (int i = 1; i < count; ++ i) {
			if (xs[i - 1] > xs[i]) {
				int tmp   = xs[i];
				xs[i]     = xs[i - 1];
				xs[i - 1] = tmp;
				swapped   = true;
			}
		}
	} while (swapped);
}

int main(void) {
	int *as, *bs, count = ReadLists(&as, &bs);

	BubbleSort(as, count);
	BubbleSort(bs, count);

	int sum = 0;
	for (int i = 0; i < count; ++ i)
		sum += abs(as[i] - bs[i]);

	printf("%i\n", sum);

	free(as);
	free(bs);
	return 0;
}

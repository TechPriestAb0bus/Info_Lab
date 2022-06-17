// There are old functions at this programm
// They need _CRT_SECURE_NO_WARNINGS for normal work
#define _CRT_SECURE_NO_WARNINGS

// Standart include
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <malloc.h>

typedef struct {
	char			name[30];
	char			surname[30];
	char			sex[30];
	char			position[30];
	unsigned int	salary;
} TTuple;

int main(int argc, char** argv) {
	FILE* f;
	TTuple* data = NULL, * tmp = NULL;
	unsigned data_count = 0;
	size_t len;
	unsigned i;
	unsigned k;
	unsigned albr;
	unsigned people;

	char buffer[5000];
	char* cursor, * cursor1;

	if (argc != 3) {
		printf("CSV scanner. Shows salary for chosen decil\n Usage:\n csv.exe <filename> <decil>\n");
		return 2;
	}

	if (NULL == (f = fopen(argv[1], "r"))) {
		fprintf(stderr, "cannot open file '%s'", argv[1]);
		return 1;
	}

	while (!feof(f)) {
		tmp = (TTuple*)realloc(data, sizeof(TTuple) * (data_count + 1));
		if (tmp == NULL) {
			fprintf(stderr, "not enough memory");
			free(data);
			return 3;
		}
		data = tmp;

		fgets(buffer, sizeof(buffer), f);
		cursor = buffer;

		// Reading name
		cursor1 = strchr(cursor, ',');
		len = cursor1 - cursor;
		strncpy(data[data_count].name, cursor, len);
		data[data_count].name[len] = 0;

		cursor = cursor1 + 1;
		// Reading surname
		cursor1 = strchr(cursor, ',');
		len = cursor1 - cursor;
		strncpy(data[data_count].surname, cursor, len);
		data[data_count].surname[len] = 0;

		cursor = cursor1 + 1;
		// Reading sex
		cursor1 = strchr(cursor, ',');
		len = cursor1 - cursor;
		strncpy(data[data_count].sex, cursor, len);
		data[data_count].sex[len] = 0;

		cursor = cursor1 + 1;
		// Reading position
		cursor1 = strchr(cursor, ',');
		len = cursor1 - cursor;
		strncpy(data[data_count].position, cursor, len);
		data[data_count].position[len] = 0;
		
		// Reading salary
		cursor = cursor1 + 2;
		sscanf(cursor, "%u", &data[data_count].salary);

		data_count++;
	}
	fclose(f);

	// Makeing decil int
	int decil = atoi(argv[2]);

	// Creating array for data
	const a = data_count;
	int *array;
	array = (int*)malloc(data_count * sizeof(int));
	for (i = 0; i < data_count; i++) {
		array[i] = data[i].salary;
	}

	for (i = 1; i < data_count; i++) {
		for (k = 1; k < data_count; k++) {
			if (array[k] > array[k + 1]) {
				albr = array[k];
				array[k] = array[k + 1];
				array[k + 1] = albr;
			}
		}
	}
	
	people = data_count / 100 * decil;

	// Decils output
	printf("\nFor decil = %u, program will show you %u people\n", decil, people);
	printf("---------------Low decil---------------------------------------\n");

	for (i = 1; i <= people; i++) {
		printf("%d\n", array[i]);
	}

	printf("---------------High decil--------------------------------------\n");

	for (i = (data_count - people); i < data_count; i++) {
		printf("%d\n", array[i]);
	}

	return 0;
}

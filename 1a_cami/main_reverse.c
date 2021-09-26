#include <stdio.h>
#include <inttypes.h>

uint64_t reverse_file(FILE* inp, FILE* out);

int main(int argc, char* argv[]) {
    if (argc != 3) {
        return -1;
    }

    FILE* fp0 = fopen(argv[1], "r");
    FILE* fp1 = fopen(argv[2], "w+");

    printf("\nname of files: %s, %s. reverse_file returns: %lu \n",
            argv[1], argv[2], reverse_file(fp0, fp1));

    fclose(fp0);
    fclose(fp1);

    return 0;
}

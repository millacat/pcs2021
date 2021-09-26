#include <stdio.h>
#include <inttypes.h>

uint64_t grabline(FILE* fd, char* buf);

int main(int argc, char* argv[]) {
    if (argc != 2) {
        return 1;
    }

    FILE* fp = fopen(argv[1], "r");
    char buf[128];

    printf("name of file: %s, grabline gives: %lu \n", argv[1],
                                                       grabline(fp, buf));
    printf("the buffer: %s\n", buf);

    fclose(fp);

    return 0;
}

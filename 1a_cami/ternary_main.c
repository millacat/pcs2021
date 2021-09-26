#include <stdio.h>
#include <inttypes.h>

// string to base ten integer
uint64_t ternary_convert(char *);

int main() {
    printf("ternary_convert(\"c\") gives: %lu, expecting 2\n", ternary_convert("c"));
    printf("ternary_convert(\"b\") gives: %lu, expecting 1\n", ternary_convert("b"));
    printf("ternary_convert(\"a\") gives: %lu, expecting 0\n", ternary_convert("a"));
    printf("ternary_convert(\"aa\") gives: %lu, expecting 0\n", ternary_convert("aa"));
    printf("ternary_convert(\"ac\") gives: %lu, expecting 2\n", ternary_convert("ac"));
    printf("ternary_convert(\"ab\") gives: %lu, expecting 1\n", ternary_convert("ab"));
    printf("ternary_convert(\"aaa\") gives: %lu, expecting 0\n", ternary_convert("aaa"));
    printf("ternary_convert(\"bb\") gives: %lu, expecting 4\n", ternary_convert("bb"));
    printf("ternary_convert(\"cc\") gives: %lu, expecting 8\n", ternary_convert("cc"));
    printf("ternary_convert(\"acc\") gives: %lu, expecting 8\n", ternary_convert("acc"));
    printf("ternary_convert(\"ccc\") gives: %lu, expecting 26\n", ternary_convert("ccc"));
    printf("ternary_convert(\"caa\") gives: %lu, expecting 18\n", ternary_convert("caa"));
    printf("ternary_convert(\"bbbb\") gives: %lu, expecting 40\n", ternary_convert("bbbb"));
    printf("ternary_convert(\"babb\") gives: %lu, expecting 31\n", ternary_convert("babb"));
    printf("ternary_convert(\"baab\") gives: %lu, expecting 28\n", ternary_convert("baab"));
    printf("ternary_convert(\"baaa\") gives: %lu, expecting 27\n", ternary_convert("baaa"));
    printf("ternary_convert(\"bacacc\") gives: %lu, expecting 305\n", ternary_convert("bacacc"));
    printf("ternary_convert(\"baaaaa\") gives: %lu, expecting 243\n", ternary_convert("baaaaa"));
    return 0;
}


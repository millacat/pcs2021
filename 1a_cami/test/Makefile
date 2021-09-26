.PHONY: all
all: ternary.o grabline.o reverse.o

ternary.o: ternary.asm
	nasm -f elf64 -o ternary.o ternary.asm

.PHONY: ternary
ternary: ternary.o 
	gcc ternary_main.c -no-pie ternary.o -o ternary && ./ternary

grabline.o: grabline.asm
	nasm -f elf64 -o grabline.o grabline.asm

.PHONY: grabline
grabline: main_grabline.c grabline.o
	gcc main_grabline.c -no-pie grabline.o -o grabline \
		&& ./grabline "testfiles/abcdeof.txt" \
		&& ./grabline "testfiles/abcdNewline.txt" \
		&& ./grabline "testfiles/toolong.txt" \
		&& ./grabline "testfiles/empty.txt"

reverse.o: reverse.asm
	nasm -f elf64 -o reverse.o reverse.asm 

.PHONY: reverse
reverse: main_reverse.c reverse.o grabline.o
	gcc main_reverse.c -no-pie reverse.o grabline.o -o rev \
	&& ./rev "testfiles/abcdeof.txt"  "out.txt"  && lolcat out.txt \
	&& ./rev "testfiles/empty.txt" "out1.txt" && lolcat out1.txt \
	&& ./rev "testfiles/twoLines.txt" "out2.txt" && lolcat out2.txt \
	&& ./rev "testfiles/toolong.txt" "out3.txt" && lolcat out3.txt

week1: echo 'lol' # change this.

# Some rules to start off for submitting code for OnlineTA
handin.zip: Makefile ternary.asm grabline.asm reverse.asm week1.pdf testfiles/  
	zip -MM $@ $^

.PHONY: onlineta
onlineta: handin.zip
	curl -F handin=@handin.zip https://pcs.incorrectness.dk/grade/week1

.PHONY: clean
clean:
	rm -f *.o ternary grabline main_grabline rev out*.txt 


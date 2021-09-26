bits 64
global ternary_convert

section .text
ternary_convert:
    mov     rax, 0          ; initial result is 0

read_char:
    mov     r8b, [rdi]      ; read first char of size byte
    inc     rdi             ; advance pointer, so able to read next char

calculate:
    cmp     r8b, 0          ; compare read character to NUL
    je      done            ; NUL is end of string, so we are done

    imul    rax, 3          ; multiply each value read by 3

    cmp     r8b, 97         ; 'a' is 97 in ascii
    jl      ternary_invalid ; if input char below 97 (invalid), then jump
    je      read_char       ; then it's an 'a' = 0, so jump back and (*3)

    cmp     r8b, 99         ; 'c' is 99 in ascii
    jg      ternary_invalid ; is input char above 99 (invalid), then jump
    je      c               ; if equal, then it's a 'c'

b: ; 1
    add     rax, 1          ; b's value is added to result
    jmp     read_char       ; jump back and (*3)

c: ; 2
    add     rax, 2          ; c's value is added to result
    jmp     read_char

done:
    ret

ternary_invalid:
    mov     rax, 0    ; 0 is return value on input string not being ternary
    ret               ; pop top value (return address) from stack, jump there

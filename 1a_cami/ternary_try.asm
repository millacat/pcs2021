global ternary_convert

section .text

ternary_convert:
    push    r13                 ; push callee registers
    push    r14
    push    r15
    mov     rax, 0              ; final result in rax
    mov     r9,  0              ; to store length of string in
    mov     r13, 0              ; stores which power of 3 is to be calculated

read_char:
    mov     r8b, [rdi]          ; read first byte of string argument
    inc     rdi                 ; advance pointer to string
    cmp     r8b, 0              ; compare input to terminating nul char
    je      calc                ; if nul, we jump to calculate final res
    cmp     r8b, 97             ; 'a' is 97 in ascii
    jl      ternary_invalid     ; if input char below 97 (invalid), then jump
    je      a                   ; if equal, then it's an 'a'
    cmp     r8b, 99             ; 'c' is 99 in ascii
    jg      ternary_invalid     ; is input char above 99 (invalid), then jump
    je      c                   ; if equal, then it's a 'c'

b:
    push    1                   ; b := 1
    inc     r9                  ; increment string length counter
    jmp read_char               ; jump back and read next character in string
a:
    push    0                   ; a := 0
    inc     r9
    jmp read_char
c:
    push    2                   ; c := 2
    inc     r9
    jmp read_char

calc:
    pop     r10
    cmp     r13, 0      ;
    je      pwrZero
    cmp     r13, 1
    je      pwrOne
    mov     r14, r13    ; can use r14 to count to 3 x 3 x .. x 3 r13 times
    dec     r14
    mov     r15, 3

power:
    imul    r15, 3
    dec     r14
    cmp     r14, 0
    jg      power
    imul    r10, r15
    add     rax, r10
    inc     r13

    cmp     r13, r9
    je      done
    jmp     calc

pwrOne:                 ; 3^1 = 3, goal: result += char value * 3^1
    imul    r10, 3      ; char value * 3
    add     rax, r10    ; added to result
    cmp     r9, 2
    je      done        ; initial length of argument string was 2
    inc     r13
;    cmp     r13, r9
;    je      done
    jmp     calc

pwrZero:                 ; 3^0 = 1
    add     rax, r10     ; add char value to result
    cmp     r9, 1        ; initial length of argument string was 1
    je      done
    inc     r13          ; increment r13 which controls what power of 3 is done
;    cmp     r13, r9      ; compare to length of string argument
;    je      done         ; if r9 was 1 they are equal and we are done
    jmp     calc

done:
    pop     r15
    pop     r14
    pop     r13
    ret

ternary_invalid:
    pop     r15
    pop     r14
    pop     r13
    mov     rax, 0
    ret                ; pop top value (return address) from stack, jump there


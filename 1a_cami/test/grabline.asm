bits 64
global grabline
extern fgetc

section .text

grabline:
    push    r12             ; push non-volatile registers
    push    r13
    mov     r12, 0          ; read character counter
    mov     r13, 0          ; flag gets set if newline is read by fgetc

read_and_handle_char:
    cmp     r12, 126        ; compare counter to 126
    je      done            ; 126 chars read and 127 wasn't eof or \n so jump

    push    rdi             ; push volatile registers
    push    rsi
    call    fgetc           ; read a char using fgetc, result in rax
    pop     rsi             ; pop volatile registers
    pop     rdi

    cmp     eax, -1         ; compare fgetc's return val to -1 : int (eof)
    je      eof             ; eof encountered, so jump (we are done reading)

    cmp     eax, 10         ; compare the char read by fgetc to newline
    je      newline         ; newline encountered, so jump (we are done reading)

    mov     [rsi + r12], al ; write char of size byte to buffer
    inc     r12             ; counter is incremented
    jmp     read_and_handle_char ; jump back and read the next ascii char

newline:
    mov     r13, 1          ; newline flag gets set

eof:
done:
    mov     BYTE [rsi + r12], 10    ; write newline to buffer
    inc     r12                     ; counter is incremented
    mov     BYTE [rsi + r12], 0     ; write terminating NUL to buffer
    lea     rax, [r12 + r13 - 1]    ; return bytes read(r13 = 1 if '\n' was met)
    pop     r13                     ; pop non-volatile registers
    pop     r12
    ret



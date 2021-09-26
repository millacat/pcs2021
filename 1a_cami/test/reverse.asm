bits 64
global reverse_file
extern grabline
extern fputs

section .text

reverse_file:
    push    r12         ; push non-volatile registers
    push    r13
    push    r14

    mov     r12, rdi    ; FILE* inp saved in r12
    mov     r13, rsi    ; FILE* out saved in r13
    mov     r14, 0      ; line counter

    sub     rsp, 128    ; allocate room on stack (+128) for grabline's buffer
    sub     rsp, 8      ; align stack

    mov     rsi, rsp    ; grabline's snd argument is buffer to write to (stack)
    call    grabline    ; grabline(FILE* inp, char* stack)
    inc     r14         ; increment line counter

    cmp     rax, 0      ; compare grabline's return value to 0
    je      done        ; if it is 0 nothing is read and we are done

recur:
    mov     rdi, r12    ; fst arg to reverse_file is FILE* inp
    mov     rsi, r13    ; snd arg is FILE* out
    call    reverse_file
    add     r14, rax    ; returns number of lines, add to line counter

write_line:
    mov     rdi, rsp    ; fst arg to fputs is char* buf (stack)
    mov     rsi, r13    ; snd arg is FILE* out
    call    fputs       ; fputs(const char* stack, FILE* out)
    mov     rax, r14    ; mov # read lines into result register rax

done:
    add     rsp, 136    ; free stack space (136 = 128 + 8)
    pop     r14         ; pop non-volatile registers
    pop     r13
    pop     r12
    ret                 ; pop top value from stack, jump there

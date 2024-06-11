; pit.asm
[BITS 16]

section .text
global init_pit

init_pit:
    ; Set PIT to mode 2 (rate generator)
    mov al, 0x36
    out 0x43, al

    ; Set frequency (e.g., 100Hz)
    mov ax, 11931          ; (1193180 / 100)
    out 0x40, al
    mov al, ah
    out 0x40, al

    ret

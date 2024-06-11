; gdt.asm
[BITS 16]
[ORG 0x500]

gdt_start:
    dq 0x0000000000000000   ; Null segment
    dq 0x00CF9A000000FFFF   ; Code segment
    dq 0x00CF92000000FFFF   ; Data segment

gdt_end:
    gdt_descriptor:
        dw gdt_end - gdt_start - 1 ; Limit
        dd gdt_start               ; Base

times 512-($-$$) db 0

section .text
global init_gdt

init_gdt:
    ; Load GDT descriptor
    lgdt [gdt_descriptor]

    ; Update segment registers
    mov ax, 0x10          ; Data segment selector
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov ax, 0x08          ; Code segment selector
    jmp ax, code_segment  ; Far jump to flush pipeline

code_segment:
    ret

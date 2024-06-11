; idt.asm
[BITS 16]
[ORG 0x600]

idt_start:
    ; Example entry for ISR 0 (divide by zero)
    dw isr0
    dw 0x08
    db 0
    db 0x8E
    dw isr0 >> 16

idt_end:
    idt_descriptor:
        dw idt_end - idt_start - 1 ; Limit
        dd idt_start               ; Base

times 512-($-$$) db 0

section .text
global init_idt

init_idt:
    ; Load IDT descriptor
    lidt [idt_descriptor]

    ; Initialize PIC
    ; ICW1 - Initialize PICs
    mov al, 0x11
    out 0x20, al
    out 0xA0, al

    ; ICW2 - Remap PIC vectors
    mov al, 0x20
    out 0x21, al
    mov al, 0x28
    out 0xA1, al

    ; ICW3 - Cascading
    mov al, 0x04
    out 0x21, al
    mov al, 0x02
    out 0xA1, al

    ; ICW4 - Environment info
    mov al, 0x01
    out 0x21, al
    out 0xA1, al

    ; Enable interrupts
    mov al, 0x0
    out 0x21, al
    out 0xA1, al

    sti

    ret

isr0:
    push ax
    mov al, 0x20
    out 0x20, al
    pop ax
    iret

; devices.asm
[BITS 16]

section .text
global init_devices

init_devices:
    ; Set keyboard ISR (interrupt 0x21)
    mov ax, 0x2100
    mov dx, isr_keyboard
    int 0x21

    ; Set mouse ISR (interrupt 0x22)
    mov ax, 0x2200
    mov dx, isr_mouse
    int 0x21

    ; Set monitor ISR (interrupt 0x23)
    mov ax, 0x2300
    mov dx, isr_monitor
    int 0x21

    ret

isr_keyboard:
    push ax
    in al, 0x60
    ; Handle keyboard input
    mov al, 0x20
    out 0x20, al
    pop ax
    iret

isr_mouse:
    push ax
    in al, 0x60
    ; Handle mouse input
    mov al, 0x20
    out 0x20, al
    pop ax
    iret

isr_monitor:
    push ax
    ; Handle monitor events
    mov al, 0x20
    out 0x20, al
    pop ax
    iret

[BITS 16]
[ORG 0x7C00]

start:
    ; Clear direction flag
    cld

    ; Load the second stage
    mov ah, 0x02           ; BIOS read sectors function
    mov al, 1              ; Number of sectors to read (we'll read 1 sector for simplicity)
    mov ch, 0              ; Cylinder number
    mov cl, 2              ; Sector number (start from sector 2, as 1 is the boot sector)
    mov dh, 0              ; Head number
    mov dl, 0x80           ; Drive number (first hard disk)
    mov bx, 0x8000         ; Address to load the second stage (0x0000:0x8000)

    int 0x13               ; BIOS interrupt to read disk

    jc disk_error          ; If carry flag is set, there was an error

    jmp 0x8000:0x0000      ; Jump to the loaded second stage

disk_error:
    ; Print error message
    mov si, error_msg      ; Point to the error message

print_loop:
    lodsb                  ; Load next byte from string into AL
    test al, al            ; Check if AL is zero (end of string)
    jz halt                ; If zero, end of string, halt the CPU
    mov ah, 0x0E           ; BIOS teletype output function
    int 0x10               ; Call BIOS video interrupt
    jmp print_loop         ; Repeat for the next character

error_msg db 'Disk Read Error', 0

halt:
    hlt                    ; Halt the CPU

times 510-($-$$) db 0      ; Pad with zeros to make 510 bytes
dw 0xAA55                  ; Boot signature (0xAA55)

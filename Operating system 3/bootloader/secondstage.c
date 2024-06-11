void print(const char* str) {
    while (*str) {
        __asm__ __volatile__ (
            "movb %0, %%al\n"
            "outb %%al, $0xE9\n"
            :
            : "r"(*str)
            : "al"
        );
        str++;
    }
}

void load_kernal() {
    //implement kernal logic
    //can invole reading multiple sectors and loading the kernal to a specific memory location
}

void main() {
    print("Second stage bootloader\n");
    load_kernal;
    void (*kernal_entry)() = (void (*)())0x1000;
    kernal_entry;
}

//expand alot.
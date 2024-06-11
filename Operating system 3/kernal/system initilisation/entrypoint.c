void kernel_main() {
    print("Kernel Initilisation\n");

    init_memory();
    init_gdt();
    init_idt();
    init_pit();
    init_keyboard();
    init_mouse();
    init_monitor();
    
    asm volatile("sti");

    print("System Initilisation\n");
    while (1) {
        //kernel idle loop(what it does when it is idle)
    }

    void init_memory() {
        //implementqation for memory initilisation
        print("Memory Initilised\n");
    }
}
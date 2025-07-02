    # x86_64 BIOS bootsector, GAS/AT&T syntax, prints "Hello, world!" on serial (COM1)

    .section .text
    .code16
    .global _start

_start:
    cli
    xor %ax, %ax
    mov %ax, %ds
    mov %ax, %es
    mov $0x7c00, %sp

    # Print string
    lea message, %si
.nextchar:
    lodsb
    test %al, %al
    jz .done
    mov $0x3F8, %dx
    mov %al, %al
    out %al, %dx
    jmp .nextchar
.done:
    mov $0, %ax
    jmp exit

    .code16
    .globl exit
    .type exit, @function

exit:
    
    # Disable interrupts
    cli

    # Check if status_code == 0
    cmp $0, %ax
    jne exit_nonzero

    # "Triple fault" by invalidating IDT and causing an interrupt
    # In real mode, IDT is at 0:0, 256*4 bytes, but we can't "lidt" with a null pointer in 16-bit.
    # Instead, try to cause a CPU reset by jumping to 0xFFFF:0000 (the reset vector)
    ljmp $0xFFFF, $0x0000

exit_nonzero:
    # Try QEMU exit (not available in 16-bit, but let's output to port 0xF4 anyway)
    mov %ax, %dx      # AL = status_code
    mov $0xF4, %dx
    out %ax, %dx

    # Try keyboard controller reset (8042)
    # Wait for input buffer empty (bit 1 clear)
kbd_wait1:
    mov $0x64, %dx
    in  %dx, %al
    test $2, %al
    jnz kbd_wait1

    # Send 0xD1 command to 0x64
    mov $0x64, %dx
    mov $0xD1, %al
    out %al, %dx

    # Wait for input buffer empty again
kbd_wait2:
    mov $0x64, %dx
    in  %dx, %al
    test $2, %al
    jnz kbd_wait2

    # Send 0xFE (reset CPU) to 0x60
    mov $0x60, %dx
    mov $0xFE, %al
    out %al, %dx

die:
    # Halt forever
    hlt
    jmp die

    .size exit, .-exit

message:
    .ascii "Hello, world!\r\n"
    .byte 0

    . = 510
    .byte 0x55
    .byte 0xAA

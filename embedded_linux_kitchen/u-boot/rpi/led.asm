.section .text
.global _start

.equ GPIO_BASE, 0x3F200000   // Base address for GPIO (Raspberry Pi 3B)
.equ GPFSEL2, 0x08           // GPIO Function Select 2 (for GPIO 20-29)
.equ GPSET0, 0x1C            // GPIO Set Register 0 (for GPIO 0-31)
.equ GPIO_PIN, 21            // GPIO pin number

_start:
    // Set GPIO pin 21 as output (GPFSEL2 covers pins 20-29, each pin needs 3 bits)
    ldr x0, =GPIO_BASE       // Load GPIO base address
    ldr x1, =GPFSEL2         // Load offset for function select register
    add x0, x0, x1           // Compute address of GPFSEL2
    ldr w2, [x0]             // Read current value

    // Clear GPIO 21 function bits
    mov w3, #(0b111 << 3)    // Bitmask to clear 3 bits (3 * (GPIO_PIN - 20))
    mov w4, #21              // GPIO number
    sub w4, w4, #20          // Adjust to function select register index
    lsl w3, w3, w4           // Shift bitmask to correct position
    bic w2, w2, w3           // Clear the bits

    // Set GPIO 21 as output (001)
    mov w3, #(0b001 << 3)    // Set as output
    lsl w3, w3, w4           // Shift to the right position
    orr w2, w2, w3           // Set the bits
    str w2, [x0]             // Write back to GPFSEL2

    // Set GPIO pin 21 high
    ldr x0, =GPIO_BASE       // Reload GPIO base address
    ldr x1, =GPSET0          // Load offset for output set register
    add x0, x0, x1           // Compute address of GPSET0
    mov w2, #(1 << GPIO_PIN) // Prepare bit mask for GPIO21
    str w2, [x0]             // Write to GPSET0 to set pin high

    // Infinite loop to prevent further execution
1:  b 1b

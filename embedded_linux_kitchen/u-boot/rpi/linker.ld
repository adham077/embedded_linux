ENTRY(_start)

SECTIONS
{
    . = 0x0;                  /* Set the start address to 0x0 */
    
    .text : {
        *(.text)              /* Place the .text section here */
    }
    
    .bss : {
        *(.bss)               /* Place the .bss section here (uninitialized data) */
    }

    .data : {
        *(.data)              /* Place the .data section here (initialized data) */
    }

    . = 0x1000;                /* Define a memory boundary for other sections, such as the stack */
}

ENTRY(_start_stage2)
OUTPUT_FORMAT("elf32-i386")

SECTIONS {
 . = 0x10000;
 .text : {
        stage2.o(.text)
        stage2_c.o(.text)
        kernel.o(.text)
   }
 .data : { *(.data) }
 .rodata : { *(.rodata) }
 .bss : { *(.bss) }
}

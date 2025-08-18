ENTRY(start)
OUTPUT_FORMAT("elf32-i386")

SECTIONS {
. = 0x7C00;
.text : { *(.text) }
.data : { *(.data) }
.rodata : { *(.rodata) }
.sig 0x7DFE : { SHORT(0xaa55) }
}

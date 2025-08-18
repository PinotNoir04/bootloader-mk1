volatile unsigned char *kernel_videomem = (volatile unsigned char *)(0xB8000);

void printh(const char *str) {
	int offset = 0;
	while (*str != 0) {
		kernel_videomem[offset] = *str;
		kernel_videomem[offset+1] = 0x02;
		str++;
		offset += 2;
	}
}

void kernel_main() {
	printh("Dummy kernel loaded");

	while(1) {
		__asm__ __volatile__ ("hlt");
	}
}

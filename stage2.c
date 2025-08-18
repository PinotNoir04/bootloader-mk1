volatile unsigned char *videomem = (volatile unsigned char*)(0xb8000);

void kernel_main();

void printg(const char *str, int x, int y) {
	int offset = (y*80+x)*2;
	while (*str != 0) {
		videomem[offset] = *str;
		videomem[offset+1] = 0x02;
		str++;
		offset += 2;
	}
}

void cls() {
	for (unsigned int i=0;i<2000;i++) {
		videomem[i*2] = ' ';
		videomem[i*2 + 1] = 0x02;
	}
}

void kmain() {
	cls();
	printg("starting kernel", 0,0);

	kernel_main();

	printg("error: no kernel", 0, 1);
	while(1);
}

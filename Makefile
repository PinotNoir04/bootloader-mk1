CC = i686-elf-gcc
AS = i686-elf-as
LD = i686-elf-ld
OBJCOPY = objcopy

CFLAGS = -ffreestanding -m32 -O2 -Wall -Wextra
ASFLAGS = --32

all: os-image.bin

os-image.bin: boot.bin payload.bin
	cat $^ > os-image.bin

boot.bin: boot.elf
	$(OBJCOPY) -O binary $< $@

boot.elf: boot.o
	$(LD) -T boot_linker.ld -o $@ $^

payload.bin: payload.elf
	$(OBJCOPY) -O binary $< $@

payload.elf: stage2.o stage2_c.o kernel.o
	$(LD) -T payload_linker.ld -o $@ $^

boot.o: boot.s
	$(AS) $(ASFLAGS) $< -o $@

stage2.o: stage2.s
	$(AS) $(ASFLAGS) $< -o $@

stage2_c.o: stage2.c
	$(CC) $(CFLAGS) -c $< -o $@

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

run: all
	qemu-system-x86_64 -fda os-image.bin

clean:
	rm -f *.o *.elf *.bin os-image.bin

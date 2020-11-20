
ASMFILE=c05_mbr.asm

all:$(ASMFILE)
	nasm -f bin $(ASMFILE) -o mbr.bin
	rm -rf myfile.vhd
	VBoxManage convertfromraw mbr.bin myfile.vhd --format VHD --variant Fixed
	dd if=mbr.bin of=a.img bs=512 count=1 conv=notrunc


asmFile=c05_mbr.asm
binFile=$(asmFile).bin
vhdFile=$(binFile).vhd
imgFile=$(binFile).img

all:$(asmFile)
	nasm -f bin $(asmFile) -o $(binFile)
	rm -rf $(vhdFile)
	VBoxManage convertfromraw $(binFile) $(vhdFile) --format VHD --variant Fixed
	dd if=$(binFile) of=$(imgFile) bs=512 count=1 conv=notrunc
	

SCRIPT=test
#MCPU=cortex-a9
MCPU=arm926ej-s
STARTUP=startup
M=versatilepb
#M=virt

all:
	arm-uclinuxeabi-as -mcpu=${MCPU} -g ${STARTUP}.s -o ${STARTUP}.o
	arm-uclinuxeabi-gcc -c -mcpu=${MCPU} -g ${SCRIPT}.c -o ${SCRIPT}.o 
	arm-uclinuxeabi-ld -T ${SCRIPT}.ld ${SCRIPT}.o ${STARTUP}.o -Map ${SCRIPT}.map -o ${SCRIPT}.elf
	arm-uclinuxeabi-objcopy -O binary ${SCRIPT}.elf ${SCRIPT}.bin

clean:
	rm -rf ${SCRIPT}.o ${SCRIPT}.elf ${SCRIPT}.bin ${STARTUP}.o

run:
	qemu-system-arm -M ${M} -nographic -kernel ${SCRIPT}.bin

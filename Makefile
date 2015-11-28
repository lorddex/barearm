SCRIPT=test
MCPU=cortex-a9
STARTUP=startup

all:
	mkdir -p ${BUILD}/
	arm-uclinuxeabi-as -mcpu=${MCPU} -g ${STARTUP}.s -o ${STARTUP}.o
	arm-uclinuxeabi-gcc -c -mcpu=${MCPU} -g ${SCRIPT}.c -o ${SCRIPT}.o
	arm-uclinuxeabi-ld -T ${SCRIPT}.ld ${SCRIPT}.o ${STARTUP}.o -o ${SCRIPT}.elf
	arm-uclinuxeabi-objcopy -O binary ${SCRIPT}.elf ${SCRIPT}.bin

clean:
	rm -rf ${SCRIPT}.o ${SCRIPT}.elf ${SCRIPT}.bin ${STARTUP}.o

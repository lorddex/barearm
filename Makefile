DEBUG=

SRC_PATH=src
BUILD_PATH=build
ASSEMBLY_PATH=assembly
C_PATH=c
SRC_C_PATH=${SRC_PATH}/${C_PATH}
SRC_ASSEMBLY_PATH=${SRC_PATH}/${ASSEMBLY_PATH}
BUILD_C_PATH=${BUILD_PATH}/${C_PATH}
BUILD_ASSEMBLY_PATH=${BUILD_PATH}/${ASSEMBLY_PATH}

RUN_BINARY=test
STARTUP_SCRIPT=startup

MCPU=cortex-a9
M=versatilepb

all: run_assembly

clean:
	${DEBUG}echo "[INFO] Removing ${BUILD_PATH} folder"
	${DEBUG}rm -rf ${BUILD_PATH}

build_assembly: clean
	${DEBUG}echo "[INFO] Compiling ASSEMBLY version into ${BUILD_ASSEMBLY_PATH} folder"
	${DEBUG}mkdir -p ${BUILD_ASSEMBLY_PATH}
	${DEBUG}arm-uclinuxeabi-as -mcpu=${MCPU} ${SRC_PATH}/${ASSEMBLY_PATH}/*.s -o ${BUILD_ASSEMBLY_PATH}/${RUN_BINARY}.bin

run_assembly: build_assembly
	${DEBUG}echo "[INFO] Starting QEMU with ASSEMBLY version"
	${DEBUG}qemu-system-arm -M ${M} -nographic -kernel ${BUILD_ASSEMBLY_PATH}/${RUN_BINARY}.bin

build_c: clean
	${DEBUG}echo "[INFO] Compiling C version into ${BUILD_C_PATH} folder"
	${DEBUG}mkdir -p ${BUILD_C_PATH}
	${DEBUG}arm-uclinuxeabi-as -mcpu=${MCPU} -g ${SRC_C_PATH}/${STARTUP_SCRIPT}.s -o ${BUILD_C_PATH}/${STARTUP_SCRIPT}.o
	${DEBUG}arm-uclinuxeabi-gcc -c -mcpu=${MCPU} -g ${SRC_C_PATH}/${RUN_BINARY}.c -o ${BUILD_C_PATH}/${RUN_BINARY}.o 
	${DEBUG}arm-uclinuxeabi-ld -T ${SRC_C_PATH}/${RUN_BINARY}.ld ${BUILD_C_PATH}/${RUN_BINARY}.o ${BUILD_C_PATH}/${STARTUP_SCRIPT}.o -Map ${BUILD_C_PATH}/${RUN_BINARY}.map -o ${BUILD_C_PATH}/${RUN_BINARY}.elf
	${DEBUG}arm-uclinuxeabi-objcopy -O binary ${BUILD_C_PATH}/${RUN_BINARY}.elf ${BUILD_C_PATH}/${RUN_BINARY}.bin

run_c: build_c
	${DEBUG}echo "[INFO] Starting QEMU with C version"
	qemu-system-arm -M ${M} -nographic -kernel ${BUILD_C_PATH}/${RUN_BINARY}.bin


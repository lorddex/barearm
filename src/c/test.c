//#define UART 0x9000000
#define UART 0x101f1000

void c_init() {
	char s[29] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '\n', '\0'};
	int i = 0;
	while(*(s+i) != '\0') {
		*((unsigned int*)UART) = (unsigned int)(*(s+i));
		i++;
	}
}

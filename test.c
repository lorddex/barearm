void print_uart0(const char *s) {
 while(*s != '\0') { /* Loop until end of string */
 *((unsigned int*)0x101f1000) = (unsigned int)(*s); /* Transmit char */
 s++; /* Next char */
 }
}
 
void c_entry() {
 print_uart0("Hello world!\n");
}

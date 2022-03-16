// escreva um programa em linguagem C que
// incremente, em ciclo infinito, 3 variáveis inteiras: a variável cnt1 deve ser incrementada a
// uma frequência de 1Hz, a variável cnt5 deve ser incrementada a uma frequência de 5Hz,
// e a variável cnt10 deve ser incrementada a uma frequência de 10Hz.

void delay(int ms){
	for(; ms > 0; ms--)
	{
	  resetCoreTimer();
	  while(readCoreTimer() < 20000);
	}
}

int main(void) {
    int cnt1 = 0;
    int cnt5 = 0;
    int cnt10 = 0;

    while(1) {
	delay(100);

	putChar('\r');
	printInt(++cnt10 , 0x0005000A);

	if(cnt10 % 2 == 0) {
		cnt5++;
	}

	if ( cnt10 % 10 == 0) {
		cnt1++;
	}

	putChar(' ');
	printInt(cnt5 , 0x0005000A);
	putChar(' ');
	printInt(cnt1 , 0x0005000A);
    }
    return 0;
}

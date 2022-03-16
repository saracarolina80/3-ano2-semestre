# O programa seguinte incrementa o valor de uma variável e de cada vez que a variável é 
# atualizada, o seu valor é apresentado no ecrã do PC. 

void main(void) 
{ 
 int counter = 0; 
 while(1) 
 { 
 	resetCoreTimer(); 
 	while(readCoreTimer() < 200000); 
 	printInt(counter++, 10 | 4 << 16); // Ver nota1
 	putChar('\r'); // cursor regressa ao inicio da linha 
 } 
 Return 0; 
} 
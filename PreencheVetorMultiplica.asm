ORG 0h

MOV R0, #50h ;Preenche primeiro vetor

loopPreencherVetor:

INC A ;Contador (Será zerado no VetorB)
INC R1 ;Valor crescente

MOV R2, A 
MOV A, R1
MOV @R0, A

CPL A ;Inverte os bits do acumulador 
MOV P1, A ;Mostra o valor através dos LED'S.
CPL A ;Inverte novamente os bits acumulador 

MOV A, R2
INC R0

CJNE A, #7h, loopPreencherVetor

CJNE R0, #57h, multiplicarVetores 	

MOV R0, #60h ;Preenche segundo vetor
MOV A, #0h
AJMP loopPreencherVetor
 
multiplicarVetores:

MOV R2, #70h ;Vetor Resultado
MOV R1, #60h ;VetorB
MOV R0, #50h ;VetorA

loopMultiplicarVetores:

MOV A, @R0
MOV B, @R1
MUL AB

MOV R3, A ; Armazenei A
MOV A, R0 ; Swap1 A = #50h
MOV R4, A ; Swap1 R4 = R0

MOV A, R2 ; Swap2 A = #70h
MOV R0, A ; RO = #70h

MOV A, R3 ; Retorna valor de A

MOV @R0, A

CPL A ;Inverte os bits do acumulador 
MOV P1, A ;Mostra o valor através dos LED'S.
CPL A ;Inverte novamente os bits acumulador

MOV A, R4;
MOV R0, A; inverte Swap

INC R2 
INC R1
INC R0

CJNE R2, #77h, loopMultiplicarVetores

CLR P1.0 ;Indica FIM (Apagando o LED)

END

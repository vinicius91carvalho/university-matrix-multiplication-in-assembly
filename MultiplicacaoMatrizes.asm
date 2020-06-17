ORG 0H

AJMP Inicio ;Pula para função inicio

mostraInicioDeOperacao:

MOV P1, #0b
MOV P1, #11111111b
MOV P1, #0b
MOV P1, #11111111b

RET

Inicio:

;Pisca LED's
ACALL mostraInicioDeOperacao

AJMP preencheMatriz

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

CJNE A, #4h, loopPreencherVetor
MOV A, #0h
;MOV R1, #0h
RET

preencheMatriz:

MOV R0, #40h
ACALL loopPreencherVetor

MOV R0, #50h ;Preenche 2ª Linha da Matriz
ACALL loopPreencherVetor

MOV R0, #60h ;Preenche 3ª linha da Matriz
ACALL loopPreencherVetor

MOV R0, #70h ;Preenche 4ª linha da Matriz
ACALL loopPreencherVetor

; Preenche a segunda matriz

ACALL mostraInicioDeOperacao

MOV R0, #45h ;Preenche a 1ª Linha da Matriz
ACALL loopPreencherVetor

MOV R0, #55h ;Preenche 2ª Linha da Matriz
ACALL loopPreencherVetor

MOV R0, #65h ;Preenche 3ª linha da Matriz
ACALL loopPreencherVetor

MOV R0, #75h ;Preenche 4ª linha da Matriz
ACALL loopPreencherVetor

; Multiplica Matrizes
AJMP MultiplicarMatriz

MulLinhaColuna:

;Captura endereço Coluna
MOV A, R7
MOV R0, A
;Captura endereço Linha
MOV A, R6
MOV R1, A

MOV A, @R0
MOV B, @R1
MUL AB

CPL A ;Inverte os bits do acumulador
MOV P1, A ;Mostra o valor através dos LED'S.
CPL A ;Inverte novamente os bits acumulador

ADD A, R4 ; Soma o resultado da Multiplicaçao com R4 e salva no Acumulador
XCH A, R4 ; Realiza a troca de conteudo

INC R7; Segunda coluna da primeira Matriz
MOV A, R6 ;Segunda linha da segunda Matriz
ADD A, #10h
XCH A, R6

DJNZ R5, MulLinhaColuna

; Armazena o resultado na Matriz R

MOV A, R3
MOV R0, A
MOV A, R4
MOV @R0, A

INC R6 ;Pula para próxima coluna da 2ª Matriz
MOV A, R6
SUBB A, #40h
MOV R6, A

MOV R5, #4h
MOV R4, #0h
INC R3

MOV A, R7 ;Volta ao início da linha
SUBB A, #4h
MOV R7, A

DJNZ R2, MulLinhaColuna

; Determina valores para próxima iteração

MOV R6, #45h ; Endereço da 1ª Linha - Matriz 2
MOV R5, #4h ; Controle de indíces da multiplicação
MOV R4, #0h ; Resultado
MOV R2, #4h ; Controle de iterações

MOV A, R7
ADD A, #10h
MOV R7, A

MOV A, R3
ADD A, #10h
SUBB A, #4h
MOV R3, A

DJNZ 10h, MulLinhaColuna

RET

MultiplicarMatriz:

; Dados Iniciais
MOV R7, #40h ; Endereço da 1ª Coluna - Matriz 1
MOV R6, #45h ; Endereço da 1ª Linha - Matriz 2
MOV R5, #4h ; Controle de indíces da multiplicação
MOV R4, #0h ; Resultado
MOV R3, #4ah ; Endereço da 1ª Linha/ Coluna Matriz Resultante
MOV R2, #4h ; Controle de iterações
MOV 10h, #4h ; Armazena na memória um contador

ACALL MulLinhaColuna

ACALL mostraInicioDeOperacao

END


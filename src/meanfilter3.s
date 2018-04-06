        PUBLIC meanfilter3              // declara p�blica a fun��o em assembly meanfilter3 para os valores declarados em C

        SECTION .text : CODE (2)        // seleciona .text na mem�ria flash
        THUMB                           // para utiliza��o das instru��es thumb-2
        
meanfilter3:
        push   {R4-R11,LR}              // aloca na pilha os valores de resgistradores n�o pertencente ao padr�o pedido no laborat�rio(ATPCS)-R4,R5,R6,R7
        
        mov    R12,#9                   // move para a o registrador 12 o valor da constante 9 para efetuar a divis�o posteriormente
        
        mov    r8,r0//,#2               // move os par�metros passados 
        mov    r9,r1//,#2               // faz tam_y_in - N + 1 // // //
        //mul    r8,r0,r1                // multiplica r0 e r1 (tam_x_in*tam_y_in) e armazena o resultado, tamanho da imagem de entrada em r4
        //mul    r9,r0,r1                // multiplica r0 e r1 e coloca o resultado, tamanho da imagem de sa�da em r9    
        mov    r10,r2                   //move para r10 o valor de mem�ria guardado em r2 (img_entrada) para liberar registradores baixos
        mov    r11,r3                   //move para r11 o valor de mem�ria guardado em r3 (img_saida) para liberar registradores baixos
        
        mov    r7,#3                    // move 3 para r7 para decrementar a cada itera��o para pegar valores das linhas
iteracoes:
        //ldr    r0,[r10]                // pega 4 primeiros bytes (32 bits)
        //ldr    r0,[r10,#3]!            // pega 4 primeiros bytes (32 bits) e atualiza o ponteiro
        //ldr    r0,[r10,#3]             // pega 4 bytes, deslocado de 3 bytes
        //ldrd   r0,r1,[r10]             // pega 8 bytes (64 bits)
        //ldr    r0,[r10]
     //#### PEGANDO VALORES DE IMG_IN E SOMANDO PARA FAZER IMG_OUT
        ldr    r0,[r10]                 // pega o valor em mem�ria apontado pelo r10 e coloca em r1
        add    r10,r8                   // soma r10 com o tamanho da linha, passado por par�metro na fun��o c, para pegar a pr�xima linha na pr�xima itera��o
        //OBS : verificar a quantidade de itera��es at� chegar no fim da imagem
        
        //bfc    r0,#24,#8               // zera o byte MSB de r0 para ficar somente com 3 posi��es
        ubfx   r4,r0,#0,#8              // move o primeiro byte(pixel) para o registrador r4
        ubfx   r5,r0,#8,#8              // copia o pr�ximo byte para r5
        add    r4,r5                    // soma r4 e r5 (2 pixels) e resultado fica no r4
        ubfx   r5,r0,#16,#8             // copia o terceiro pixel da linha
        add    r4,r5                    // soma r4 com r5 novamente e resultado fica em r4
        add    r6,r4                    // soma os pixels no r6 para fazer a divis�o posteriormente
        
        subs    r7,r7,#1                // decrementa r7 de 1
        //cmp    r7,r6                   // compara r7 com 0 (fim das 3 linhas)
        //bmi    iteracoes               // enquanto o resultado da compara��o n�o for igual, volta para itera��es (VERIFICAR O SALTO)
        //cbnz r7, iteracoes
        cmp    r7,#0                    // compara r7 com 0
        bne    iteracoes                // pula para itera��es enquanto r7 n�o for 0
        //it     ne
        //       bne iteracoes
          
        
     //#### FIM DA SOMA DAS 3 LINHAS. FAREMOS A DIVIS�O POR 9 E COLOCAREMOS O VALOR NA IMG_OUT
        udiv   r6,r12                    // divide r6(resultado da soma das 3 linhas) por r12(9)
        strb   r6,[r11],#1               // grava o resultado em r6 no byte do endere�o de img_out apontado por r11 e desloca 1
 
        pop   {R4-R11,PC}                // retira da pilha os registradores que n�o fazem parte do padr�o ATPCS. Faz um salto para o Linker Register(LR) retornando a subrotina em C, com o PC(program counter)

        END                              // termina o programa em assembly


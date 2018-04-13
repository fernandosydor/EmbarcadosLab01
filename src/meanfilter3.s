//################################################################################
//#                             Laborat�rio 01
//#                          Turma S12 - Equipe 01
//#
//#     Luiz Fernando Gomes Sydor
//#     Maria Augusta Alves Sousa
//#     Marlon Mateus Prudente de Oliveira
//#
//################################################################################

        PUBLIC meanfilter3              // declara p�blica a fun��o em assembly meanfilter3 para os valores declarados em C
        SECTION .text : CODE (2)        // seleciona .text na mem�ria flash
        THUMB                           // para utiliza��o das instru��es thumb-2
        
meanfilter3:
        push   {R4-R11,LR}              // aloca na pilha os valores de resgistradores n�o pertencentes ao padr�o ATPCS - R4 a R11
                
        mov    r8,r0                    // move r0 para r8 para liberar registrador baixo (valor de x de img_in)
        mov    r9,r1                    // move para r9 o tamanho da imagem em y
        sub    r9,r9,#2                 // faz tam_y - N + 1 para controlar as itera��es em y
        mov    r1,r0                    // move o valor de tam_x para r1
        sub    r1,r1,#2                 // faz tam_x - N + 1 para controlar as itera��es em x
        mov    r10,r2                   // move para r10 o valor de mem�ria guardado em r2 (img_entrada) para liberar registradores baixos
        mov    r11,r3                   // move para r11 o valor de mem�ria guardado em r3 (img_saida) para liberar registradores baixos
        //mov    R12,#9                   // move para a o registrador 12 o valor da constante 9 para efetuar a divis�o posteriormente
        mul    r12,r1,r9
        mov    r3,r1                    // como r1 ser� alterado, move para r3 o valor das itera��es em x para controlar nos loops em x e y

loopy:                                  // loop para pegar cada linha
        mov    r1,r3

loopx:                                  // loop para percorrer cada posi��o de cada linha
        mov    r6,#0                    // inicializa r6 para colocar o resultado da divis�o
        mov    r7,#3                    // move 3 para r7 para decrementar a cada itera��o para pegar valores das linhas

calcula:                                // fun��o que calcula os valores de cada pixel para a imagem de sa�da
        ldr    r0,[r10]                 // pega o valor em mem�ria apontado pelo r10 e coloca em r1
        add    r10,r8                   // soma r10 com o tamanho da linha, passado por par�metro na fun��o c, para pegar a pr�xima linha na pr�xima itera��o        
        ubfx   r4,r0,#0,#8              // move o primeiro byte(pixel) para o registrador r4
        ubfx   r5,r0,#8,#8              // copia o pr�ximo byte para r5
        add    r4,r5                    // soma r4 e r5 (2 pixels) e resultado fica no r4
        ubfx   r5,r0,#16,#8             // copia o terceiro pixel da linha
        add    r4,r5                    // soma r4 com r5 novamente e resultado fica em r4
        add    r6,r4                    // soma os pixels no r6 para fazer a divis�o posteriormente
        sub    r7,r7,#1                 // decrementa r7 de 1
        cmp    r7,#0                    // compara r7 com 0
        bne    calcula                  // pula para itera��es enquanto r7 n�o for 0
        
        //udiv   r6,r12                   // divide r6(resultado da soma das 3 linhas) por 9
        mov     r4,#0x1c72              // Move para r4 o valor da constante com 16 casas de precis�o - ((2^16)/9) + 1 = 0x1c72(hexa) = 7282(decimal)
        mul     r6,r6,r4                // Para realizar a divis�o sem o uso da instru��o de divis�o usa-se a constante calculada multiplicada pela soma encontrada R6 = R6 * R4(0x1c72)
        lsr     r6,r6,#16               // Desloca em 16 bits(precis�o) o r6 e encontra o valor da divis�o do r6 por 9, com uma precis�o aceit�vel
        
        strb   r6,[r11],#1              // grava o resultado em r6 no byte do endere�o de img_out apontado por r11 e desloca 1
        
        sub    r1,r1,#1                 // subtrai 1 de r1
        cmp    r1,#0                    // compara r1 com 0 para ver se j� pode come�ar a itera��o na pr�xima linha de y
        ittee ne                        // enquanto n�o chegar no fim da linha x (r1=0), soma 1 em r10 para come�ar no pr�ximo pixel
          addne    r2,#1
          movne    r10,r2
          addeq    r2,#3                // quando chegar no fim da linha x, adiciono 3 para come�ar da pr�xima linha y e movo para r10
          moveq    r10,r2
        bne    loopx                    // salta para itera��o de linhas enquanto a linha n�o tiver acabado

        sub    r9,r9,#1                 // subtrai 1 de r9
        cmp    r9,#0                    // compara r9 com 0 para ver se chegou na �ltima linha
        bne    loopy                    // salta para o loopy enquanto n�o tiver pego dados de todas as linhas
        
        mov    r0,r12
        pop    {R4-R11,PC}               // retira da pilha os registradores que n�o fazem parte do padr�o ATPCS. Faz um salto para o Linker Register(LR) retornando a subrotina em C, com o PC(program counter)
        
        //bx lr                           // retorna para o main.c
        
        END                             // termina o programa em assembly


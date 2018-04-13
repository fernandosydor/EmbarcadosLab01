#include <stdint.h>                                                             // inclus�o da biblioteca para declara��o do uint
#include <stdlib.h>                                                             // inclus�o da biblioteca para utiliza��o do malloc

//############################_DEFINI��ES_ENTRADA_##############################
// ser�o alteradas futuramente

#define tam_x_in 5                                                              // define o tamanho para o eixo x da imagem de entrada
#define tam_y_in 6                                                              // define o tamanho para o eixo y da imagem de entrada

uint8_t img_entrada[tam_x_in*tam_y_in] = {1,2,3,4,5,
                                          6,7,8,9,10,
                                          11,12,13,14,
                                          15,16,17,18,19,
                                          20,21,22,23,24,25,
                                          26,27,28,29,30};
  
//uint8_t img_entrada[tam_x_in*tam_y_in] = {2,3,4,5,6,                            // cria o vetor da imagem de entrada
//                                          8,9,10,11,12,
//                                          14,15,16,17,18,
//                                          19,20,21,22,23,
//                                          7,8,9,10,11};

//###########################_DEFINI��ES_SAIDA_#################################

#define tam_x_out tam_x_in-3+1
#define tam_y_out tam_y_in-3+1

extern uint32_t meanfilter3(uint16_t dim_x, uint16_t dim_y, uint8_t img_in[], uint8_t img_out[]); // assinatura requisitada pelo professor. Linker vai encontrar a fun��o meanfilter3

//###########################_FUN��O_PRINCIPAL_#################################

int main(){
  
  uint8_t *img_saida;                                                           // ponteiro de img_saida para o endere�o de uint8_t
  img_saida = malloc(tam_x_out*tam_x_in);                                       // aloca sequencialmente os blocos de bytes de sa�da
  
  int x;  
  x = meanfilter3(tam_x_in, tam_y_in, img_entrada, img_saida);                  // retorna n�mero total de pixels da imagem de sa�da
  
  free(img_saida);                                                              // libera espa�o para uma futura reciclagem das aloca��es feitas na mem�ria
  img_saida = NULL;                                                             // zera os bytes alocados na mem�ria
  
  return 0;
}


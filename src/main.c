#include <stdint.h>                                                             // inclusão da biblioteca para declaração do uint
#include <stdlib.h>                                                             // inclusão da biblioteca para utilização do malloc

//############################_DEFINIÇÕES_ENTRADA_##############################
// serão alteradas futuramente

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

//###########################_DEFINIÇÕES_SAIDA_#################################

#define tam_x_out tam_x_in-3+1
#define tam_y_out tam_y_in-3+1

extern uint32_t meanfilter3(uint16_t dim_x, uint16_t dim_y, uint8_t img_in[], uint8_t img_out[]); // assinatura requisitada pelo professor. Linker vai encontrar a função meanfilter3

//###########################_FUNÇÃO_PRINCIPAL_#################################

int main(){
  
  uint8_t *img_saida;                                                           // ponteiro de img_saida para o endereço de uint8_t
  img_saida = malloc(tam_x_out*tam_x_in);                                       // aloca sequencialmente os blocos de bytes de saída
  
  int x;  
  x = meanfilter3(tam_x_in, tam_y_in, img_entrada, img_saida);                  // retorna número total de pixels da imagem de saída
  
  free(img_saida);                                                              // libera espaço para uma futura reciclagem das alocações feitas na memória
  img_saida = NULL;                                                             // zera os bytes alocados na memória
  
  return 0;
}


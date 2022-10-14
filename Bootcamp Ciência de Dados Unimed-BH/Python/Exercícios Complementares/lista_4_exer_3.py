#lista_4_exer_3
#Um  time  de basquete  possui  12  jogadores. 
import random
import statistics
#Obs: a função deverá receber por parâmetro a matriz e imprimir os resultados dentro da função.
#através de uma função faça os seguintes cálculos: 
def jog(matriz):
  #a.o nome e a altura do jogador mais alto
  for i in range(len(matriz)):
    print(matriz[i])
  print('----')
  maior_altura = max(matriz[1])
  idx = matriz[1].index(max(matriz[1]))
  print('A maior altura é: ', maior_altura)
  print('O Jogador de maior altura é: ', matriz[0][idx])
  #b.a média de altura do time
  media = statistics.mean(matriz[1])
  print(f'A média das alturas é {media:.2f}')
#######################################
#Faça um programa  que  preencha uma matriz  com  o nome  e  a  altura  dos  jogadores
matriz = []
for i in range(2):
  linha = []
  for j in range(3):
    if i == 0:
      linha.append('Jogador '+str(j+1))
    if i == 1:
      linha.append(round(random.uniform(1.75,2.35),2))
  matriz.append(linha)
########################################
print('Chamando a função')
print('-----')
jog(matriz)
print('-----')
print('Encerrando a função')
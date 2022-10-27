#Escreva um  programa  que  preencha  uma  matriz 4 x 6 com  números  inteiros, calcule e mostrena tela:
import statistics
from random import randint
matriz = []
#i é linha
#j é coluna
for i in range(4):
  lista = []
  for j in range(6):
    lista.append(randint(0,100))
  matriz.append(lista)
quantidade_num_entre_10_e_30 = soma_num_maior_10_e_par = soma_4_coluna = media_3 =0
#a) A quantidade de números que estão no intervalo entre 10 e 30
for i in range(4):
  for j in range(6):
    if matriz[i][j] > 10 and matriz[i][j] < 30:
      quantidade_num_entre_10_e_30 += 1
#b) A soma dos números maiores que 10 e pares
    if matriz[i][j] > 10 and matriz[i][j] % 2 == 0:
      soma_num_maior_10_e_par += matriz[i][j]
#c)A soma dos números que estão na quarta coluna da matriz
    if j == 3:
      soma_4_coluna += matriz[i][j]
for i in range(4):
  print(matriz[i])
print('----')
print(f'A quantidade de números que estão no intervalo entre 10 e 30: {quantidade_num_entre_10_e_30}')
print(f'A soma dos números maiores que 10 e pares: {soma_num_maior_10_e_par}')
print(f'A soma dos números que estão na quarta coluna da matriz: {soma_4_coluna}')
#d)A média dos números da matriz que estão na terceira linha
print(f'A média dos números da matriz que estão na terceira linha: {statistics.mean(matriz[2])}' )

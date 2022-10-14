from random import randint
import statistics
#Escreva um programa em Python que preencha uma matriz de ordem 5x5 com números inteiros
matriz = []
for i in range(5):
  linha = []
  for j in range(5):
    linha.append(randint(0,20))
  matriz.append(linha)
# mostre na tela a matriz preenchida.
for i in range(5):
  print(matriz[i])
print('---')
#Calcule e mostre na tela:
mult_3 = []
media_linha_5 = []
qtde = 0
menor = matriz[0][0]
media_das_linhas = []
for i in range(5):
  #• faça a média dos números de cada linha da matriz e armazene em uma lista. (2 pts)
  media_das_linhas.append(statistics.mean(matriz[i]))
  for j in range(5):
    #• A média dos números múltiplos de 3; (1,5 pts)
    if matriz[i][j] % 3 == 0:
      mult_3.append(matriz[i][j])
    #• o menor número da coluna 3, ou seja, índice 2; (1,5 pts)
    if j == 2:
      if matriz[i][j] < menor:
        menor = matriz[i][j]
    #• a média dos números da 5ª linha da matriz, ou seja, índice 4; (1,5 pts)
    if j == 4:
      media_linha_5.append(matriz[i][j])
    #• a quantidade de números da matriz que são ímpares, e maiores ou iguais a 10 e menores ou iguais a 15; (1,5 pts)
    if matriz[i][j] % 2 == 1 and matriz[i][j] >= 10 and matriz[i][j] <= 15:
      qtde += 1
print(f'A média dos números multiplos de 3: {statistics.mean(mult_3):.2f}')
print(f'O menor número da coluna 3, ou seja, índice 2 é: {menor}')
print(f'A média dos números da 5ª linha da matriz, ou seja, índice 4 é: {statistics.mean(media_linha_5):.2f}')
print(f'A quantidade de números da matriz que são ímpares, e maiores ou iguais a 10 e menores ou iguais a 15 é: {qtde}')
print(f'A média dos números de cada linha da matriz: {media_das_linhas}')
#Escreva um   programa   que leia uma   matriz   6   x   10,   some   as   colunas individualmente  e  acumule  as  somas  na  7ª  linha  da  matriz.  O  programa deverá mostrar o resultado de cada coluna.
from random import randint
matriz = []
for i in range(6):
  linha = []
  for j in range(10):
    linha.append(randint(0,100))
  matriz.append(linha)
for i in range(6):
  print(matriz[i])
print('----')
coluna_0 = coluna_1 = coluna_2 = coluna_3 = coluna_4 = coluna_5 = coluna_6 = coluna_7 = coluna_8 = coluna_9 = 0
for i in range(6):
  for j in range(10):
    if j == 0:
      coluna_0 += matriz[i][0]
    if j == 1:
      coluna_1 += (matriz[i][1])
    if j == 2:
      coluna_2 += (matriz[i][2])
    if j == 3:
      coluna_3 += (matriz[i][3])
    if j == 4:
      coluna_4 += (matriz[i][4])
    if j == 5:
      coluna_5 += (matriz[i][5])
    if j == 6:
      coluna_6 += (matriz[i][6])
    if j == 7:
      coluna_7 += (matriz[i][7])
    if j == 8:
      coluna_8 += (matriz[i][8])
    if j == 9:
      coluna_9 += (matriz[i][9])
lista = []
lista.append((coluna_0))
lista.append((coluna_1))
lista.append((coluna_2))
lista.append((coluna_3))
lista.append((coluna_4))
lista.append((coluna_5))
lista.append((coluna_6))
lista.append((coluna_7))
lista.append((coluna_8))
lista.append((coluna_9))
matriz.append(lista)
for i in range(7):
  print(matriz[i])
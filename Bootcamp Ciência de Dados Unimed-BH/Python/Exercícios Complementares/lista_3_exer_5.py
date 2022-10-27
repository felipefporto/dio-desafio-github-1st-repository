#Escreva um  programa  que  preencha  uma  matriz 4 x 3 com  números  inteiros, calcule e mostrena tela:
from random import randint
matriz = []
for i in range(4):
  linha = []
  for j in range(3):
    linha.append(randint(1,6))
  matriz.append(linha)
for i in range(4):
  print(matriz[i])
print('---')
soma_primos = 0
for i in range(4):
  for j in range(3):
#b)A soma dos números primos    
    cont_primos = 0
    num = matriz[i][j]
    for k in range(1,num+1):
      if num % k == 0:
        cont_primos += 1
    if cont_primos == 2:
      soma_primos += num
print('A soma dos números primos: ',soma_primos)
#a)A soma dos elementos que estão na 2ª e 4ª linha da matriz
print('A soma dos elementos que estão na 2ª linha: ', sum(matriz[1]))
print('A soma dos elementos que estão na 4ª linha: ', sum(matriz[3]))

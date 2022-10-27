#Escreva um programa que leia uma matriz de ordem 5 x 4, onde na 1ª coluna da matriz é armazenado o nome do vendedor,  da  2ª  coluna  a  4ª  coluna são armazenados o total de vendas por mês de cada vendedor, portanto na 2ªcoluna é armazenado a venda do mês  1,  3ª  coluna do  mês  2 e na 4ª  coluna do mês 3. 
#Calcule e mostre na tela:
from random import randint
matriz = []
for i in range(5):
  linha = []
  for j in range(3):
    if j == 0:
      linha.append('Vendedor '+str(i+1))
    linha.append(randint(10000,20000))
  matriz.append(linha)
for i in range(5):
  print(matriz[i])
print('-----')
soma_venda = []
maior_venda_mes_1 = []
menor_venda_mes_3 = []
total_venda_mes_2 = []
for i in range(5):
  linha = []
  for j in range(4):
    if j != 0:
#a) O valor total vendido por vendedor
      linha.append(matriz[i][j])
    soma_venda.append(linha)
#d) O total vendido por mês de todos os vendedores
#b) A maior venda do mês 1
    if j == 1:
      maior_venda_mes_1.append(matriz[i][j])
    if j == 2:
      total_venda_mes_2.append(matriz[i][j])
#c) A menor venda do mês 3
    if j == 3:
      menor_venda_mes_3.append(matriz[i][j])
for i in range(5):
  print('O total vendido pelo', matriz[i][0], 'foi de: R$',sum(soma_venda[i]))
print('A maior venda do mês 1 foi de: ', max(maior_venda_mes_1))
print('A menor venda do mês 3 foi de: ', min(menor_venda_mes_3))
print('O total vendido por mês de todos os vendedores:  \n Mês 1: ',sum(maior_venda_mes_1),'\n Mês 2: ', sum(total_venda_mes_2), '\n Mês 3: ', sum(menor_venda_mes_3))

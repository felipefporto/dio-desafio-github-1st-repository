#lista_3_exer_7
#A  prefeitura  de  uma  cidade  fez  uma  pesquisa  entre  seus  habitantes,  coletando dados sobre  o salário, idade e o número  de filhos. Escrevaum programa que  leia esses  dados,  por  exemplo  para  10  pessoas.  Armazene  esses  dados  em  uma matriz, depois calcule e mostre:
import statistics
from random import randint
matriz = []
for i in range(3):
  linha = []
  for j in range(10):
    if i == 0: #salario
      linha.append(randint(500,3000))
    if i == 1: #idade
      linha.append(randint(14,60))
    if i == 2: #num filhos
      linha.append(randint(0,4))
  matriz.append(linha)
for i in range(3):
  print(matriz[i])
#a)A média de salário da população
print('A média de salário da população: ', statistics.mean(matriz[0]))
#b)A média do número de filhos
print(f'A média do número de filhos: {statistics.mean(matriz[2]):.2f}')
quantidade = 0
media_20_30 = []
for i in range(3):
  for j in range(10):
#c)A quantidade de filhos das pessoas que tem idade entre 15 a 25 anos
    if matriz[1][j] > 15 and matriz[1][j] < 25:
      quantidade += 1
#d)A média de salário de pessoas que tem idade entre 20 a 30 anos
    if matriz[1][j] > 20 and matriz[1][j] < 30:
      media_20_30.append(matriz[0][j])
print('A quantidade de filhos das pessoas que tem idade entre 15 a 25 anos: ', quantidade)
if sum(media_20_30) > 0:
  print(f'A média de salário de pessoas que tem idade entre 20 a 30 anos: {statistics.mean(media_20_30):.2f}')
else:
  print('A média de salário de pessoas que tem idade entre 20 a 30 anos: 0')
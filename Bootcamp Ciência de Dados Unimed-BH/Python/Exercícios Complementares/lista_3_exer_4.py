#Escreva um  programa  que  armazene  em  uma  matriz,  o  nome  e  duas  notas  de  5 alunos. 
from random import randint
import statistics
matriz = []
for i in range(3):
  linha = []
  for j in range(5):
    if i == 0:
      linha.append('Aluno '+str(j+1))
    if i == 1 or i == 2:
      linha.append(randint(0,10))
  matriz.append(linha)
print('---')
for i in range(3):
  print(matriz[i])
print('---')
#Calcule e armazene em uma lista a média de cada aluno e em outra lista o status (media>= 6, “aprovado”, caso contrário, “reprovado”)
media_notas = []
lista_status = []
for j in range(5):
  media_notas.append((matriz[1][j]+matriz[2][j])/2)
  if (matriz[1][j]+matriz[2][j])/2 >= 6:
    lista_status.append('aprovado')
  else:
    lista_status.append('reprovado')
print(media_notas)
print(lista_status)
#faça uma opção para  que  o usuário possa  fazer  uma pesquisar  por  nome.  Se encontrar seja exibido na tela: 
name = str(input('Qual o nome que deseja procurar?: '))
while name.upper() != "FIM":
# o nome do aluno;
  if name in matriz[0]:
    print('A posição em que foi encontrado,',name,',  no índice: linha 0 e coluna: ' , matriz[0].index(name))
# as duas notas e a média;
    print('A nota 1 foi de: ', matriz[1][matriz[0].index(name)])
    print('A nota 2 foi de: ', matriz[2][matriz[0].index(name)])
    print('A média foi de: ', media_notas[matriz[0].index(name)])
#o status;
    print('O status é de: ', lista_status[matriz[0].index(name)])
  else:
    print('O nome não foi encontrado')
  print('Se deseja encerrar digite: FIM')
  name = str(input('Qual o nome que deseja procurar?: '))

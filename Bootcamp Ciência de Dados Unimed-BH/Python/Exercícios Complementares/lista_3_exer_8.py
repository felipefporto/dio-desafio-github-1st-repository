#Lista_3_exer_8
#Escreva um  programa  que  preencha  uma  listar  com  os  nomes  de 10 alunos,  e outra lista com a média dos alunos. Calcule e mostre:
from random import randint
import statistics
lista_alunos = []
lista_notas = []
maior_nota = posicao = 0
for i in range(10):
  lista_alunos.append('Aluno '+str(i+1))
for i in range(10):
  lista_notas.append(randint(0,10))
  maior_nota = max(lista_notas)
  posicao_maior_nota = lista_notas.index(max(lista_notas))
print(lista_alunos)
print(lista_notas)
print('---')
#a)a média da classe;
print('A média da classe: ', statistics.mean(lista_notas))
quantidade_1 = quantidade_2 = 0
for j in range(10):
#b)a quantidade de alunos que tiveram média igual ou superior a 7;
  if lista_notas[j] >= 7:
    quantidade_1 += 1
#c)a quantidade de alunos que tiveram média abaixo de 7
  else:
    quantidade_2 += 1
print('A quantidade de alunos que tiveram média igual ou superior a 7: ', quantidade_1)
print('A quantidade de alunos que tiveram média abaixo de 7: ', quantidade_2)
#d)A maior média da classe e nome do aluno que obteve a maior média
print('A maior média da sala foi', max(lista_notas), 'do', lista_alunos[posicao])
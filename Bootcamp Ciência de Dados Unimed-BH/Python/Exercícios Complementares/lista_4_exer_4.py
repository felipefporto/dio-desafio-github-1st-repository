#Escreva uma função que receba como parâmetro a nota de um  estudante, converte o valor de nota para um conceito (A, B, C, D, E e F).Imprima o resultado dentro da função.
def conceito(nota):
  if nota < 0 or nota > 10:
    print('Digite uma nota válida!')
  elif nota < 6:
    print('Nota F')
  elif nota >= 6 and nota < 6.99:
    print('Nota D')
  elif nota >= 7 and nota < 7.99:
    print('Nota C')
  elif nota >= 8 and nota < 8.99:
    print('Nota B')
  elif nota >= 9 and nota <= 10:
    print('Nota A')
#########################################
nota = float(input('Digite a nota do aluno (de 0 a 10): '))
print('Chamando a função')
conceito(nota)
print('Encerrando a função')
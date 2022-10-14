#lista_4_exer_2
#equação do segundo grau
def delta(a,b,c):
  rdelta = (b**2) - (4*a*c)
  return rdelta
#############################################
#receba três valores, 'a', 'b' e 'c'
n1 = int(input('Digite um valor para a: '))
n2 = int(input('Digite um valor para b: '))
n3 = int(input('Digite um valor para c: '))
#############################################
print('----')
print('Chamando a função')
#retorne o valor do delta, que é dado por 'b² -4ac’.
resdelta = delta(n1,n2,n3)
print('O Valor do Delta é: ', resdelta)
print('----')
print('Encerrando o programa')
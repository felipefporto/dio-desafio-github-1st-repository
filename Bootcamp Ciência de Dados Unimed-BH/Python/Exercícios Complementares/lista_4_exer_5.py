#Escreva uma função que receba como parâmetro uma lista com 10 nomes e um nome para pesquisa. 
#Essa função deverá realizar uma busca do nome na lista, 
#retornando TRUE se encontrar ou FALSE se não encontrar.
def busca(name):
  if name in nomes:
    return True
  else:
    return False
##################################
nomes = []
for i in range(10):
  nomes.append('Nome '+str(i+1))
##################################
name = str(input('Qual o nome que deseja procurar?: '))
print('Se deseja encerrar digite: FIM')
while name.upper() != "FIM":
# o nome do aluno;
  busca(name)
  if busca(name):
    if True:
      print('TRUE: A posição em que foi encontrado,',name,',  na coluna: ' , nomes.index(name)+1)
    else:
      print('FALSE: O nome não foi encontrado')
  name = str(input('Qual o nome que deseja procurar?: '))
##################################
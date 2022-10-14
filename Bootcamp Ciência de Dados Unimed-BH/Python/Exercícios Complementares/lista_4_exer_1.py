#lista_4_exer_1
#verifique  se  ele  é perfeito, ou seja, se a soma dos seus divisores EXCETO ele mesmo dá o próprio número,
def perfeito(n1):
  global verificador
  verificador = 0
  for i in range(1,num,1):
    if num % i == 0:
      verificador += i
  if (verificador == num):
    return True
  else:
    return False
#receba  1  número  inteiro  como  parâmetro
##############################################
num = int(input("Digite um número: "))
##############################################
print('Chamando função')
#a mensagem se o número é perfeito ou não, deve ser mostrada no programa principal.
res = perfeito(num)

if res == True:
  print("O número é perfeito")
else:
  print("O número NÃO é perfeito")

print('Encerrando programa')
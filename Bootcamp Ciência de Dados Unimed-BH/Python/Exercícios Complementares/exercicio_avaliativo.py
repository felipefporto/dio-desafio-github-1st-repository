import statistics
nome = []
idade = []
peso = []
peso_40_50 = []
cont_peso_maior_60 = []
#Escreva um programa que leia nomes, 5 idades e 5 pesos, e armazene cada informação e uma lista.
for i in range(5):
  nome.append(str(input('Digite o seu nome: ')))
  idade.append(int(input('Digite a sua idade: ')))
  peso.append(float(input('Digite o seu peso: ')))
  # c) A média de peso das pessoas que tem idade entre 40 e 50 anos (inclusive)
  if idade[i] >= 40 and idade[i] <= 50:
    peso_40_50.append(peso[i])
  # e)	A quantidade de pessoas com peso superior a 60 kg 
  if peso[i] > 60:
    cont_peso_maior_60.append(1)
# a)	A maior idade e o nome da pessoa dessa pessoa 
print(nome[idade.index(max(idade))],'tem a maior idade que é de ',max(idade),'anos')
# b)	A média das idades
print('A média das idades é: ', statistics.mean(idade))
# c) A média de peso das pessoas que tem idade entre 40 e 50 anos (inclusive)
print('A média de peso das pessoas que tem idade entre 40 e 50 anos (inclusive) é de: ', statistics.mean(peso_40_50))
# d) A quantidade de pessoas com idade maior que a média de idades
idade_maior_media = []
for i in range(len(idade)):
  if idade[i] > statistics.mean(idade):
    idade_maior_media.append(1)
    
print('A quantidade de pessoas com idade maior que a média de idades é de: ', sum(idade_maior_media))
# e)	A quantidade de pessoas com peso superior a 60 kg 
print('A quantidade de pessoas com peso superior a 60 kg é de: ', sum(cont_peso_maior_60))
# f)	Faça um relatório que mostre na tela o nome, a idade e o peso de cada pessoa
for i in range(5):
  print('Nome: ', nome[i], '- Idade: ',idade[i],'- Peso: ', peso[i])
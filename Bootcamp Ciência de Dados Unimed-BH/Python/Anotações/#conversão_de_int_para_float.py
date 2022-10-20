#Repare na barra do operador matemático de divisão
numero = 10
print(numero)
print('Divisão com uma barra 10/2:', numero/2, '. Repare que o número é do tipo float.')
print('Divisão com duas barras 10//2:', numero//2, ". Repare que o número é do tipo int.")
#Repare na estrutura
idade = 29
preco = 10
texto = f"Idade {idade} preço {preco}"
print(texto)
#Recebendo uma string
teste = input("Digite um número: ")
print("A string digitada será convertida para int: ", int(teste))
print('----')
print('Repare que ao converter um número do tipo float para int o número não é arredondado para o valor mais próximo, \n o sistema na verdade trunca o número, simplesmente cortando as casas decimais')
decimal = 1.987654
print('Antes da conversão: ', decimal)
print('Depois da conversão: ', int(decimal))
print('mas qual é o tipo dessa variável decimal agora? Veja: ',type(decimal))
print('Repare que o valor é declarado como float porque ele apenas foi printado na tela como valor inteiro e não armazenado na variável')
nao_sou_mais_uma_decimal = int(decimal)
print('Depois de armazenar a variável convertida obtemos: ', type(nao_sou_mais_uma_decimal))
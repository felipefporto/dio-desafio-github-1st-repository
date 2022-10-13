curso = "pYtHon"
print("Upper: ",curso.upper())
print("Lower: ",curso.lower())
print("Title: " ,curso.title())
curso = "       Python       "
print("Remove espaços em branco: ",curso.strip())
print("Remove os espaços em branco da esquerda: ",curso.lstrip())
print("Remove os espaços em branco da direita: " ,curso.rstrip())
curso = "Python"
print(curso.center(10, "#"))
print(".".join(curso))

#Interpolar Variáveis
#Método format
nome = "Felipe"
idade = 29
profissao = "Supervisor Comercial"
linguagem = "Python"

print('Olá, me chamo {3}. Eu tenho {2} anos, trabalho como {1} e estou matriculado no curso {0}.'.format(linguagem,profissao,idade,nome))
print('Olá, me chamo {nome}. Eu tenho {idade} anos, trabalho como {profissao} e estou matriculado no curso {linguagem}.'.format(nome=nome, idade=idade,profissao=profissao,linguagem=linguagem))
pessoa = {'nome': "Felipe", 'idade': "29", 'profissao': "Supervisor Comercial", 'linguagem': "Pyhont"}
print('Olá, me chamo {nome}. Eu tenho {idade} anos, trabalho como {profissao} e estou matriculado no curso {linguagem}.'.format(**pessoa))
#Método f-string
print(f'Olá, me chamo {nome}. Eu tenho {idade} anos, trabalho como {profissao} e estou matriculado no curso {linguagem}.')
PI = 3.14159
print(f"Valor de PI com 2 casas decimais: {PI:.2f}")
print(f"Valor de PI com 10 casas inteiras e 2 decimais: {PI:10.2f}")
#string de multiplas linhas ou triplas
mensagem = f"""Olá,
meu nome é {nome},
Estou aprendendo Python
"""
print(mensagem)
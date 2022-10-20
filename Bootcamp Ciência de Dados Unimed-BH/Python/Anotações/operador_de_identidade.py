#Operador de Identidade
curso = "Python"
nome_curso = curso
saldo, limite = 200, 200
#Verificando se estão no mesmo caminho de memória
print("Curso is nome_curso: ", curso is nome_curso)
print("Curso is not nome_curso: ", curso is not nome_curso)
print("Saldo is Limite: " ,saldo is limite)
saldo_2 = 1000
limite_2 = 1000
print("saldo_2 is limite_2: ", saldo_2 is limite_2)
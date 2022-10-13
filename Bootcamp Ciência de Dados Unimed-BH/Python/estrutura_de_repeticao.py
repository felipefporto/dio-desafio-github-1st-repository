texto = "repetição"
VOGAIS = "AEIOUÃ"

for letra in texto:
    if letra.upper() in VOGAIS:
        print(letra, end="") #usa o end para imprimir na mesma linha
else:
    print()
    print("Executa no final do laço")
    
for i in range(10):
    if i % 2 == 0:
        continue
    print(i, end=" ")
    

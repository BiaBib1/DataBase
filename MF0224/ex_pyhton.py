### EXERCISES IN PYTHON ###

"""
## NUMERO PARI O DISPARI ####
n = int(input("Digita un numero: "))
if n%2 == 0:
    print("El número es par")
else: 
    print("El número no es par")

#### INTERVALLO ####
n = int( input("Insertar un numero compreso entre 1 y 10 "))
if 1 < n <= 10:
    print("El numero es correcto")
else:
    print("El numero no es correcto")

#### NUMERO MAS GRANDE O IGUAL A 10 ####
n = int(input("insertar un numero "))
for i in range (1, 11):
    if 1 < n <= 10:
        print ("Que suerte!!")
    else:
        print("No es correcto")
    break

### DICE GAME ###
import random

print("Welcome player 1! Please press enter to continue")
input()

print("Rolling the dice...")    

player1_roll = random.randint(1, 6) 

print("Player 1 rolled: ", player1_roll)    

print("Welcome player 2! Please press enter to continue")       
input() 

print("Rolling the dice...")    

player2_roll = random.randint(1, 6)

print("Player 2 rolled: ", player2_roll)

if player1_roll > player2_roll:
    print("Player 1 wins!")

elif player1_roll < player2_roll:
    print("Player 2 wins!")
"""

### CASINO GAME ###
import random

print("Player1 choose a number between 1 and 20")
player1_number = int(input())

print("Player2 is your turn to choose a number between 1 and 20")
player2_number = int(input())

pc= random.randint(1, 20)
print("The computer chose: ", pc)

if player1_number == pc:
    print("Player1 wins!")

elif player2_number == pc:
    print("Player2 wins!")

else:
    print("You loose!")


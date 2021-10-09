.data
stringaPresentazione: .asciiz 
	"Questo programma ha il solo scopo di essere usato per debuggare un metodo di una libreria\n"
	"per manipolazione stringhe.\n\nIl metodo in questione riceve come argomento una stringa\n"
	"e ne stampa gli anagrammi, ovvero tutte le combinazioni possibili date dalla permutazione\n"
	"delle lettere di tale stringa.\n\n"
	"Per questione di tempo computazionale elevato si consiglia in input una stringa\n"
	"al di sotto degli 8 caratteri (il numero di anagrammi di una stringa lunga n-caratteri\n"
	"e' di n-fattoriale (n!)).\n\n"
stringaPromptInput:   .asciiz "Inserire stringa: "
stringaPromptOutput1: .asciiz "Sono stati generati "
stringaPromptOutput2: .asciiz " anagrammi a partire da: "
stringaPromptOutput3: .asciiz "! = "
stringaVuota:         .asciiz ""
newLine:              .asciiz "\n"

.text
.globl main
main:
	la $a0, stringaPresentazione			# a0 = stringaPresentazione
	addi $v0, $zero, 4				# v0 = 4
	syscall 					# print_string		
	
	la $a0, stringaPromptInput			# a0 = stringaPromptInput
	addi $v0, $zero, 4				# v0 = 4
	syscall 					# print_string			
	
	addi $v0, $zero, 8				# v0 = 8
	syscall	# read_string				# a0 = string_byte_address
	move $s0, $a0					# s0 = a0 (string_byte_address)

	la $a0, newLine					# a0 = '\n'
	addi $v0, $zero, 4				# v0 = 4
	syscall						# print_string			

# ELABORAZIONE INPUT ($s7 incrementato a ogni stringa completata) #
# (incremento implementato nel metodo Anagramma della libreria_stringhe) #
	move $s7, $zero					# s7 = 0 (contatore stringhe integrato nel metodo Anagramma)
                                    			# (usato solo per convenzione)
	
	la $a0, stringaVuota				# a0 = ""
	move $a1, $s0					# a1 = s0 (string_byte_address)
	jal functionAnagramma				# void

	
# OUTPUT & PROOF_OF_WORK #
	la $a0, newLine					# a0 = '\n'
	addi $v0, $zero, 4				# v0 = 4
	syscall						# print_string
	
	la $a0, stringaPromptOutput1			# a0 = stringaPromptOutput1
	addi $v0, $zero, 4				# v0 = 4
	syscall 					# print_string
	
	move $a0, $s7					# a0 = s7 (contatoreStringhe)
	addi $v0, $zero, 1				# v0 = 1
	syscall 					# print_int
	
	la $a0, stringaPromptOutput2			# a0 = stringaPromptOutput2
	addi $v0, $zero, 4				# v0 = 4
	syscall 					# print_string
	
	move $a0, $s0					# a0 = s0 (string_byte_address)
	addi $v0, $zero, 4				# v0 = 4
	syscall 					# print_string
	
	move $a0, $s0					# a0 = s0 (string_byte_address)
	jal functionStringLength
	
	move $a0, $v0					# a0 = v0 (stringLength)
	addi $v0, $zero, 1				# v0 = 1
	syscall						# print_int
	
	la $a0, stringaPromptOutput3			# a0 = stringaPromptOutput3
	addi $v0, $zero, 4				# v0 = 4
	syscall						# print_string
	
	move $a0, $s7					# a0 = s7 (contatoreStringhe)
	addi $v0, $zero, 1				# v0 = 1
	syscall 					# print_int
	
	la $a0, newLine					# a0 = '\n'
	addi $v0, $zero, 4				# v0 = 4
	syscall 					# print_string
	

# EXIT #
	addi $v0, $zero, 10				# v0 = 10
	syscall						# exit

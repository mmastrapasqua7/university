########################################
##                                    ##
##  PROGRAMMA DI RIFERIMENTO IN JAVA  ##
##                                    ##
########################################
##
## import java.util.Scanner;
##
## public class Anagramma {
## 		public static void main(String[] args) {
##     			Scanner input = new Scanner(System.in);
##  			String parola = "";
##
##			System.out.print("Scrivi una parola: ");
##			parola = input.next();
##		
##			functionAnagramma("", parola);
## 		}
##
## 		public static void functionAnagramma(String prefisso, String suffisso) {
##			if (suffisso.length() > 0) {
##				for(int i = 0; i < suffisso.length(); i++) {
##					String arg0 = prefisso + "" + suffisso.charAt(i);
##					String arg1 = suffisso.substring(0, i) + "" +
##						suffisso.substring(i + 1, suffisso.length());
##			
##					functionAnagramma(arg0, arg1);
##				}
##			} else {
##				System.out.println(prefisso + "" + suffisso);
##			}
## 		}
## }

.data
stringaVuota: .asciiz ""
newLine:      .asciiz "\n"

.text
.globl functionAnagramma
.globl functionCharAtIndex
.globl functionConcat
.globl functionStringLength
.globl functionSubstringFromTo

############################################
# METODO ANAGRAMMA STRINGA (VOID)          #
#                                          #  
# anagramma($a0)                           #
# $a0 = string                             #
############################################

functionAnagramma:
	addi $sp, $sp, -24         # _stack_push_6_word
	sw $ra, 20($sp)            # 	_stack_save_ra		   	-> 20($sp)
	sw $a1, 16($sp)            # 	_stack_save_(suffisso) 		-> 16($sp)
	sw $a0, 12($sp)            # 	_stack_save_(prefisso) 		-> 12($sp)
	sw $t2, 8($sp)             # 	_stack_save_(ARG_0)	   	-> 8($sp)
	sw $t1, 4($sp)             # 	_stack_save_t1         		-> 4($sp)
	sw $t0, 0($sp)             # 	_stack_save_t0         		-> 0($sp)
	
	move $a0, $a1              # a0 = a1 (suffisso)
	jal functionStringLength   # v0 = suffisso.length()
	sw $v0, 4($sp)             # 	_stack_save_(suffisso.length()) -> 4($sp)
	
	lw $a0, 12($sp)            #	_stack_restore_(prefisso)
	lw $a1, 16($sp)            # 	_stack_restore_(suffisso)
	
functionAnagrammaIF:
	beq $v0, $zero, functionAnagrammaELSE # suffisso.length() == 0 ? goto ELSE
	
	addi $t0, $zero, 0         # t0 = 0 (int i = 0)
	sw $t0, 0($sp)             #	_stack_save_t0 -> 0($sp)
	
functionAnagrammaFOR:
	lw $v0, 4($sp)             # 	_stack_restore_(suffisso.length()) -> v0
	beq $t0, $v0, functionAnagrammaEND # i == suffisso.length() ? goto END
		
    # (ARG_0) prefisso + suffisso.charAt(i)
    # suffisso.charAt(i)
    	move $a0, $a1          	   # a0 = a1 (suffisso)
    	move $a1, $t0          	   # a1 = t0 (i)
    	jal functionCharAtIndex	   # v0 = suffisso.charAt(i)
    
    	lw $t0, 0($sp)        	   # 	_stack_restore_(i) -> t0
    	lw $a0, 12($sp)        	   #	_stack_restore_(prefisso) -> a0
	
    	move $a1, $v0              # a1 = suffisso.charAt(i)
    	jal functionConcat         # v0 = prefisso + suffisso.charAt(i) (ARG_0)
    	sw $v0, 8($sp)             # 	_stack_save_(ARG_0) -> 8($sp)
	
    	lw $t0, 0($sp)             # 	_stack_restore_(i) -> t0
    	lw $a1, 16($sp)            # 	_stack_restore_(suffisso) -> a1
    
    # (ARG_1) suffisso.substring(0,i) + suffisso.substring(i+1,suffisso.length())	
    # suffisso.substring(0, i)
    	move $a0, $a1          	   # a0 = a1 (suffisso)
    	move $a1, $zero        	   # a1 = 0  (zero)
    	move $a2, $t0          	   # a2 = t0 (i)
    	jal functionSubstringFromTo
    
    	lw $t0, 0($sp)         	   # 	_stack_restore_(i) -> t0
    	lw $a1, 16($sp)        	   # 	_stack_restore_(suffisso) -> a1
    	move $t5, $v0          	   # t5 = suffisso.substring(0, i)
	
    # suffisso.substring(i + 1, suffisso.length())
    	move $a0, $a1          	   # a0 = a1 (suffisso)
    	addi $a1, $t0, 1       	   # a1 = t0 + 1 (i + 1)
    	lw $a2, 4($sp)         	   # 	_stack_restore_(suffisso.length()) -> a2
    	jal functionSubstringFromTo	# v0 = suffisso.substring(i + 1, suffisso.length())
	
	move $a0, $t5              # a0 = suffisso.substring(0, i)
	move $a1, $v0              # a1 = suffisso.substring(i + 1, suffisso.length())
	jal functionConcat         # v0 = suffisso.substring(0,i) + suffisso.substring(i+1,suffisso.length() (ARG_1)
	
    # functionAnagramma(ARG_0, ARG_1)
	lw $a0, 8($sp)             # 	_stack_restore_(ARG_0) -> a0
	move $a1, $v0              # a1 = v0 (ARG_1)
	jal functionAnagramma
	
    # functionAnagramma END
	lw $t0, 0($sp)             # 	_stack_restore_(i) -> t0
	lw $a0, 12($sp)            #	_stack_restore_(prefisso) -> a0
	lw $a1, 16($sp)            # 	_stack_restore_(suffisso) -> a1
	
	addi $t0, $t0, 1           # t0++ (i++)
	sw $t0, 0($sp)             # 	_stack_save_(i) -> 0($sp)
	
	j functionAnagrammaFOR
	
functionAnagrammaELSE:
	addi $v0, $zero, 4         # v0 = 4
	syscall			   # print_string
	
	move $a0, $a1              # a0 = a1 (suffisso)
	addi $v0, $zero, 4         # v0 = 4
	syscall 		   # print_string
	
	la $a0, newLine            # a0 = '\n'
	addi $v0, $zero, 4         # v0 = 4
	syscall			   # print_string

	addi $s7, $s7, 1           # s7++ (numero_stringhe_generate++)
    				   # usato solo per convenzione, da eliminare (sovrascrive registro $s7 senza salvarlo)
	
	j functionAnagrammaEND
	
functionAnagrammaEND:
	lw $ra, 20($sp)            #	_stack_restore_ra -> ra
	addi $sp, $sp, 24          # _stack_pop_8_word
	
	jr $ra                     # return 0

############################################
# METODO CONCATENA STRINGA (RETURN STRING) #
#                                          #  
# concat($a0, $a1) ---> return $v0         #
# $a0 = string0, $a1 = string1	       	   #
############################################

functionConcat:
	addi $sp, $sp, -16         # _stack_push_4_word
	sw $a0, 0($sp)             #	_stack_save_a0	(string0)
	sw $a1, 4($sp)             # 	_stack_save_a1	(string1)
	sw $v0, 8($sp)             # 	_stack_save_v0
	sw $ra, 12($sp)            #	_stack_save_ra
	
	jal functionStringLength   # v0 = string0.length()
	sw $v0, 8($sp)             # 	_stack_save_(string0.length()) -> 8($sp)
	
	move $a0, $a1              # a0 = a1 (string1)
	jal functionStringLength   # v0 = string1.length()
	
	lw $a0, 8($sp)             #	_stack_restore_(string0.length()) -> a0
	add $a0, $a0, $v0          # a0 = a0 + v0 (string0.length() + string1.length())
	
	addi $a0, $a0, 1           # a0 += 1 (minimo 1 byte)
	addi $v0, $zero, 9         # v0 = 9
	syscall			   # sbrk (v0 = new_string_byte_address)
	sw $v0, 8($sp)             # 	_stack_save_(new_string_byte_address) -> 8($sp)
	
	addi $t0, $zero, 0         # t0 = 0 (int i = 0)
	addi $t8, $zero, 2         # t8 = 2 (stringsQueued)
	addi $t9, $zero, 10        # t9 = 10 (char c = '\n')
	
	lw $a0, 0($sp)             #	_stack_restore_(string0) -> a0
	lw $a1, 4($sp)             #	_stack_restore_(string1) -> a1
	
functionConcatFOR:
    # for(i = 0; string.charAt(i) != NULL && string.charAt(i) != 0; i++)
    #     newString.concat(string.charAt(i);
	
	lb $t1, 0($a0)             # t1 = string.charAt(i)
	beq $t1, $zero, functionConcatREPEAT # t1 == NULL ? goto REPEAT
	beq $t1, $t9, 	functionConcatREPEAT # t1 == '\n' ? goto REPEAT
	sb $t1, 0($v0)             # newString += string.charAt(i)  
	addi $a0, $a0, 1           # a0++ (string_byte_address++)
	addi $v0, $v0, 1           # v0++ (new_string_byte_address++)
	addi $t0, $t0, 1           # t0++ (i++)
	j functionConcatFOR
	
functionConcatREPEAT:
	addi $t8, $t8, -1          # t8-- (stringsQueued--)
	beq $t8, $zero, functionConcatEND # stringsQueued == 0 ? goto END
	move $a0, $a1              # a0 = string1
	addi $t0, $zero, 0         # t0 = 0 (int i = 0)
	j functionConcatFOR
	
functionConcatEND:
	sb $zero, 0($v0)           # newString += NULL byte (termina stringa)

	lw $ra, 12($sp)            # 	_stack_restore_ra
	lw $v0, 8($sp)             #	_stack_restore_(new_string_byte_address)
	addi $sp, $sp, 16          # _stack_pop_4_word
	
	jr $ra                     # return string

#########################################
# METODO LUNGHEZZA STRINGA (RETURN INT) #
#                                       #
# stringLength($a0)                     #
# $a0 = stringa				#
#########################################

functionStringLength:											
	addi $t0, $zero, 0         # t0 = 0 (lunghezza)
	addi $t9, $zero, 10        # t9 = 10 (char c = '\n')

functionStringLengthFOR:											
	lb $t1, 0($a0)             # t1 = charAt(string_byte_address)
	beq $t1, $zero, functionStringLengthEND	# t1 == NULL ? goto END
	beq $t1, $t9, 	functionStringLengthEND	# t1 == '\n' ? goto END
	addi $t0, $t0, 1           # t0++ (lunghezza++)			
	addi $a0, $a0, 1           # a0++ (string_byte_address++)
	j functionStringLengthFOR

functionStringLengthEND:
	move $v0, $t0              # v0 = t0 (lunghezza)
	jr $ra                     # return lunghezza

###############################################
# METODO CARATTERE ALL'INDICE (RETURN STRING) #
#                                             #
# charAt($a0, $a1)                            #
# $a0 = stringa, $a1 = indice		      #
###############################################

functionCharAtIndex:						
	add $a0, $a0, $a1          # a0 += a1 (string_byte_address + offset)
	lb $t0, 0($a0)             # t0 = charAt(string_byte_address + offset)
	
	addi $a0, $zero, 1         # a0 = 1 (stringa da 1 byte)  
	addi $v0, $zero, 9         # v0 = 9 (malloc(a0 bytes))
	syscall # sbrk             # v0 = new_string_byte_address
	
	sb $t0, 0($v0)             # 0($v0) = charAt(string_byte_address + offset)
	jr $ra                     # return new_string_byte_address


###############################################
# METODO SOTTOSTRINGA (RETURN STRING) 	      #
#                                             #
# substring($a0, $a1, $a2)                    # 
# $a0 = string, 			      #
# $a1 = startIndex, $a2 = lastIndex(excluded) #
###############################################
	
functionSubstringFromTo:
	move $t0, $a0              # t0 = a0 (string)
	move $t1, $a1              # t1 = a1 (startIndex)
	move $t2, $a2              # t2 = a2 (lastIndex)
	
	sub $a0, $t2, $t1          # a0 = t2 - t1 (dimTot = lastIndex - startIndex)
	addi $a0, $a0, 1           # a0++ (minimo 1 byte per stringa vuota (NULL))
	addi $v0, $zero, 9         # v0 = 9 (malloc(a0 bytes))
	syscall #sbrk              # v0 = new_string_byte_address

	addi $a0, $a0, -1          # a0-- (-1 byte dimensione reale)
	addi $sp, $sp, -4          # _stack_push_1_word
	sw $v0, 0($sp)             #   _stack_save_(new_string_byte_address) -> 0($sp)
	
	beq $a0, $zero, functionSubstringFromToEND # dimTot == 0 ? goto END
	
	add $t0, $t0, $t1          # t0 += t1 (string_byte_address + startIndex)
	
functionSubstringFromToFOR:
	sub $t3, $t2, $t1          # t3 = t2 - t1 (lastIndex - startIndex = dimTot)
	beq $t3, $zero, functionSubstringFromToEND # dimTot == 0 ? goto END
	
	lb $t3, 0($t0)             # t3 = string_byte_address (char)
	sb $t3, 0($v0)             # newString += string_byte_address
	addi $t0, $t0, 1           # t0++ (string_byte_address++)
	addi $v0, $v0, 1           # v0++ (new_string_byte_address++)
	addi $t1, $t1, 1           # t1++ (startIndex++)
	j functionSubstringFromToFOR
	
functionSubstringFromToEND:
	sb $zero, 0($v0)           # newString += NULL byte (termina stringa)
	lw $v0, 0($sp)             #   _stack_restore_(new_string_byte_address) -> v0
	addi $sp, $sp, 4           # _stack_pop_1_word
	jr $ra                     # return

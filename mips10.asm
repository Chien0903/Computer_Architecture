.data
    err_message: .asciiz "Yeu cau nhap so nguyen trong khoang tu 0 den 999.999.999"

    zero: .asciiz "khong "
    blank: .asciiz ""
    one: .asciiz "mot "
    two: .asciiz "hai "
    three: .asciiz "ba "
    four: .asciiz "bon " 
    five: .asciiz "nam "
    six: .asciiz "sau "
    seven: .asciiz "bay"
    eight: .asciiz "tam "
    nine: .asciiz "chin "
    ten: .asciiz "muoi "
    ones: .word blank, one, two, three, four, five, six, seven, eight, nine, ten
    teen: .asciiz "muoi "
    trilion: .asciiz "ty "
    million: .asciiz "trieu "
    thousand: .asciiz "nghin "
    hundred: .asciiz "tram "
    linh: .asciiz "linh "
    hundred2: .asciiz "khong tram"
    
    Message: .asciiz "Enter a number (0 to 999999999): "
    break: .asciiz "\n"
    space: .asciiz " "
.text
main:
# ------------------------
# t1 luu dia chi mang ones
# ------------------------
	# luu mang ones vao t1
	la $t1, ones
# ----------------------------------
# Nhap input cho chuong trinh vao s0
# ----------------------------------
input:
	
	# nhap so nguyen
	li $v0, 51
	la $a0, Message
	syscall 
	move $s0, $a0 			# s0 luu input
    
	bltz $s0, err 			# nhap lai neu input < 0 ( yeu cau 0 -> 999.999.999)
	#bgt $s0, 999999999, err		# nhap lai neu input > 999.999.999 ( yeu cau 0 -> 999.999.999)
        	beqz $s0, print_zero 		# Neu dau vao = 0, in ra "zero"
        	j convert_to_word		# goi ham xu ly chinh
        	
print_zero:
	# in ra "zero" neu dau vao = '0'
 	li $v0, 4
 	la $a0, zero
 	syscall
 	# thoat chuong trinh
 	j exit
#---------------------------------------------------------------------
# @brief Ham doi so thanh cach doc cua no
# @param[in] s0 luu tru dau vao
# @return ghi truc tiep ket qua ra output
# @note 
#---------------------------------------------------------------------
convert_to_word:
	convert_zero:
	li $s1, 0
	divu $a1, $s0, 1000000000
	bge $s0 ,1000000000 ,convert_three_digit
	convert_one:
	add $s1, $s1, 1			# s1 = 1 danh dau dang xu ly o nhom 3 so million
	div $s0, $s0, 1000000000
	mfhi $s0
	addi $t0, $s0, -999999		# t0 = Input - 999999
	sub $t0, $zero, $t0		# t0 = 999999 - Input
	divu $a1, $s0, 1000000		# a1 = Input / 1000000 => Lay 3 chu so nhom million cua Input
	bltz $t0, convert_three_digit   # Neu t0 < 0 => t0 >= 1000000 => Xu ly in ra cac so o nhom million
	
	
	# chuyen doi 3 chu so tiep theo
	convert_second:
	addi $s1, $s1, 1		# s1 = 2 danh dau dang ly o nhom 3 so thousand
	
	div $s0, $s0, 1000000		# lay Input chia cho 1000000
	mfhi $s0			# chuyen phan du cua phep chia vao Input
					# => Lay Input %= 1000000 hay lay 6 chu so cuoi cua Input
	addi $t0, $s0, -999		# t0 = Input - 999
	sub $t0, $zero, $t0		# t0 = 999 - Input
	divu $a1, $s0, 1000		# a1 = Input / 1000 => Lay 3 chu so nhom hundred cua Input
	bltz $t0, convert_three_digit	# Neu t0 < 0 => t0 >= 1000 => Xu ly in ra cac so o nhom hundred
	
	convert_third:
	addi $s1, $s1, 1 		# s1 = 3 danh dau dang ly o nhom 3 so cuoi
	
	div $s0, $s0, 1000		# lay Input chia cho 1000
	mfhi $s0			# chuyen phan du cua phep chia vao Input
					# => Lay Input %= 1000 hay lay 3 chu so cuoi cua Input
	blt $s0,100, print_hundred
	move $a1, $s0			# gan a1 = Input, vi chi con 3 chu so cuoi can xu ly
	beq, $a1, 0 ,exit
	j convert_three_digit

exit:
	li $v0, 10
	syscall
#---------------------------------------------------------------------
# @brief Ham doi tung bo ba so thanh cach doc cua no
# @param[in] a1 luu so co nhieu nhat 3 chu so
# @return ghi truc tiep ket qua ra output
# @note 
#---------------------------------------------------------------------
convert_three_digit:
	bgt $a1, 99, convert_hundred			# a1 >= 100 => Xu ly in ra voi so hang tram
	convert_1:
	bgt $a1, 19, convert_greater_equal_than_20	# a1 >= 20 => Xu ly so hang chuc >= 20
	bgt $a1, 9, convert_greater_equal_than_10	# 10 <= a1 < 20 => Xu ly so hang chuc < 20
	convert_2:
	bgez $a1, convert_unit				# Xu ly so hang don vi
convert_hundred:
	# in ra hang tram
	li $s2, 100
	div $a1, $s2
	mflo $t5
	sll $t5, $t5, 2
	move $t6, $t1				# gan dia chi mang "ones" vao t6
	add $t6, $t6, $t5			# t6 = dia chi ones[index]
	lw $a0, ($t6)				# a0 = ones[index]
	li $v0, 4				
	syscall					# in ra ones[index]
	
	la $a0, hundred				# in ra chu "hundred"
	syscall

	div $a1, $a1, $s2			# a1 %= 100
	mfhi $a1				# => giu 2 chu so hang chuc va don vi cua a1 de xu ly tiep
	blt $a1, 10,print_0_hundred
	j convert_1
	
	
convert_greater_equal_than_20:
	# in ra hang chuc >= 20
	li $s2, 10
	div $a1, $s2 	# lay ra chu so hang chuc >= 2
	mflo $t5
	sll $t5, $t5, 2		# lay ra index cua chu so hang tram trong mang "tens"
	move $t6, $t1		# gan dia chi mang "tens" vao t6
	add $t6, $t6, $t5	# t6 = dia chi tens[index]
	lw $a0, ($t6)		# a0 = tens[index]
	li $v0, 4
	syscall			# in ra tens[index]
	la $a0, teen		
	syscall
	div $a1, $a1, $s2	# a1 %= 10
	mfhi $a1		# => => giu chu so hang don vi cua a1 de xu ly tiep
	beq $a1, $zero, exit
	j convert_2
	
convert_greater_equal_than_10:
	# in ra hang chuc >=10 < 20
	li $v0, 4
	la $a0, teen		# in dau cach 
	syscall
	div $a1, $a1, 10	# a1 %= 10
	mfhi $a1		# => => giu chu so hang don vi cua a1 de xu ly tiep
	j convert_2
convert_unit:
	# in ra hang don vi
	 
	sll $a1, $a1, 2		# lay ra chu so hang don vi 
	move $t6, $t1		# gan dia chi mang "ones" vao t6
	add $t6, $t6, $a1	# t6 = dia chi ones[index]
	lw $a0, ($t6)		# a0 = ones[index]
	li $v0, 4
	syscall			# in ra ones[index]
	
	beq $s1, 0, print_trilion
	beq $s1, 1, print_million	# da xu ly xong nhom 3 so, dua vao s1 de in ra million hay thousand
	beq $s1, 2, print_thousand
	beq $s1, 3, exit
	

print_million:
	# in ra chu "million"
	li $v0, 4
	la $a0, million
	syscall
	
	j convert_second
	
print_thousand:
	# in ra chu "thousand"
	li $v0, 4
	la $a0, thousand
	syscall
	
	j convert_third
print_hundred:
	# in ra chu "thousand"
	beqz $s0,exit
	li $v0, 4
	la $a0, zero
	syscall
	li $v0, 4
	la $a0, hundred
	syscall
	add $a1, $s0, $zero
	j convert_1
print_trilion:
	li $v0, 4
	la $a0, trilion
	syscall
	j convert_one
print_0_hundred:
	li $v0, 4
	la $a0, linh
	syscall
	j convert_1
err:
	li $v0, 55
	la $a0, err_message
	li $a1, 0
	syscall
	j input

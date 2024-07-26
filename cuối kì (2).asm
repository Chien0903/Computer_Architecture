.data
ln1: .asciiz 	"                                                *************     \n"
ln2: .asciiz 	"**************                                 *3333333333333*    \n"
ln3: .asciiz 	"*222222222222222*                              *33333********     \n"
ln4: .asciiz 	"*22222******222222*                            *33333*            \n"
ln5: .asciiz 	"*22222*      *22222*                           *33333********     \n"
ln6: .asciiz 	"*22222*       *22222*       *************      *3333333333333*    \n"
ln7: .asciiz 	"*22222*       *22222*     **11111*****111*     *33333********     \n"
ln8: .asciiz 	"*22222*       *22222*   **1111**       **      *33333*            \n"
ln9: .asciiz 	"*22222*      *222222*   *1111*                 *33333********     \n"
ln10: .asciiz 	"*22222*******222222*   *11111*                 *3333333333333*    \n"
ln11: .asciiz 	"*2222222222222222*     *11111*                  *************     \n"
ln12: .asciiz 	"***************        *11111*                                    \n"
ln13: .asciiz 	"       ---              *1111**                                   \n"
ln14: .asciiz 	"     / o o \             *1111****   *****                        \n"
ln15: .asciiz 	"     \  >  /              **111111***111*                         \n"
ln16: .asciiz 	"      -----                 ***********        dce.hust.edu.vn    \n"
menu1: .asciiz 	"1. In ra man hinh\n"
menu2:.asciiz	"2. Xoa mau\n"
menu3:.asciiz 	"3. Doi vi tri\n"
menu4:.asciiz 	"4. Doi mau\n"
menu5:.asciiz	"\n5.Doi vi tri E va D"
menu6:.asciiz	"\n6.Doi vi tri E va C"
menu7: .asciiz	"\n7.Doi vi tri C va D\n"
color_D: .asciiz	"\nChon mau moi cho D: "
color_E: .asciiz	"\nChon mau moi cho E: "
color_C: .asciiz	"\nChon mau moi cho C: "
wrong_color: .asciiz "\nMau khong hop le!!! Vui long chon lai"

.text 
main:
	jal show_menu
	nop
	
	li $v0,5
	syscall
	
	beq $v0,1, print
	nop
	
	beq $v0,2 delete_color
	nop
	
	beq $v0,3,change_EandC
	nop
	
#	beq $v0,3,show_menu2
#	nop
	
	beq $v0,4,color
	nop
	
end_main:
	li $v0,10
	syscall
show_menu:
	la $a0, menu1
	li $v0,4
	syscall
	
	la $a0, menu2
	li $v0, 4
	syscall
	
	la $a0, menu3
	li $v0, 4
	syscall
	
	la $a0, menu4
	li $v0, 4
	syscall
	
	jr $ra
show_menu2:
	la $a0, menu5
	li $v0,4
	syscall
	
	la $a0, menu6
	li $v0,4
	syscall
	
	la $a0, menu7
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	beq $v0,5,change_EandD
	nop
	
	beq $v0,6,change_EandC
	nop
	
	beq $v0,7,change_CandD
	nop
print:
	la $a0, ln1
	li $v0, 4
	syscall
	
	la $a0, ln2
	li $v0, 4
	syscall 
	
	la $a0, ln3
	li $v0, 4
	syscall 
	
	la $a0, ln4
	li $v0, 4
	syscall 
	
	la $a0, ln5
	li $v0, 4
	syscall 
	
	la $a0, ln6
	li $v0, 4
	syscall 
	
	la $a0, ln7
	li $v0, 4
	syscall 
	
	la $a0, ln8
	li $v0, 4
	syscall 
	
	la $a0, ln9
	li $v0, 4
	syscall 
	
	la $a0, ln10
	li $v0, 4
	syscall 
	
	la $a0, ln11
	li $v0, 4
	syscall 
	
	la $a0, ln12
	li $v0, 4
	syscall 
	
	la $a0, ln13
	li $v0, 4
	syscall 
	
	la $a0, ln14
	li $v0, 4
	syscall 
	
	la $a0, ln15
	li $v0, 4
	syscall
	
	la $a0, ln16
	li $v0, 4
	syscall 

	 j end_main
	
delete_color:
	la $k0, ln1
	jal delete
	nop

	la $k0, ln2
	jal delete
	nop

	la $k0, ln3
	jal delete
	nop
	
	la $k0, ln4
	jal delete
	nop
	
	la $k0, ln5
	jal delete
	nop
	
	la $k0, ln6
	jal delete
	nop
	
	la $k0, ln7
	jal delete
	nop
	
	la $k0, ln8
	jal delete
	nop
	
	la $k0, ln9
	jal delete
	nop
	
	la $k0, ln10
	jal delete
	nop
	
	la $k0, ln11
	jal delete
	nop
	
	la $k0, ln12
	jal delete
	nop
	
	la $k0, ln13
	jal delete
	nop
	
	la $k0, ln14
	jal delete
	nop
	
	la $k0, ln15
	jal delete
	nop

	j print
delete:
	li $a1, 0
loop1:     
  
	add $k1, $k0, $a1
	lb $t1, 0($k1)
	beq $t1, '\n', end_delete
	blt $t1, '0', skip_loop1
	bgt $t1, '9', skip_loop1
	la $t1, ' '
	sb $t1, 0($k1)
skip_loop1:
	add $a1, $a1,1
	j loop1
end_delete:  
	jr $ra
change_EandD:
	la $k0, ln1
	jal change_ED
	nop
	
	la $k0, ln2
	jal change_ED
	nop
	
	la $k0, ln3
	jal change_ED
	nop	
	
	la $k0, ln4
	jal change_ED
	nop	
	
	la $k0, ln5
	jal change_ED
	nop	
	
	la $k0, ln6
	jal change_ED
	nop	
	
	la $k0, ln7
	jal change_ED
	nop	
	
	la $k0, ln8
	jal change_ED
	nop	
	
	la $k0, ln9
	jal change_ED
	nop	
	
	la $k0, ln10
	jal change_ED
	nop	
	
	la $k0, ln11
	jal change_ED
	nop	
	
	la $k0, ln12
	jal change_ED
	nop	
	
	la $k0, ln13
	jal change_ED
	nop	
	
	la $k0, ln14
	jal change_ED
	nop	
	
	la $k0, ln15
	jal change_ED
	nop	
	
	la $k0, ln16
	jal change_ED
	nop
	
	j print
change_ED:
	li $a1, 0		# 0->20 -> chu D, 21: dau cach 
			# 22-> 42 -> chữ C, 43: dau cach
			# 44-> 63 -> chữ E, 64: dau cach
			# 65-> \n
loop2:
	beq $a1, 21, end_ED
	add $a2,$a1,44
	add $s1, $k0,$a1
	add $s2, $k0,$a2
	lb $t1, 0($s1) #D
	lb $t2, 0($s2) #E
	sb $t1, 0($s2)
	sb $t2, 0($s1)  
	
	addi $a1, $a1, 1	# Tang bien dem len 1
	j loop2
end_ED: 
	jr $ra
change_EandC:
	la $k0, ln1
	jal change_EC
	nop
	
	la $k0, ln2
	jal change_EC
	nop
	
	la $k0, ln3
	jal change_EC
	nop	
	
	la $k0, ln4
	jal change_EC
	nop	
	
	la $k0, ln5
	jal change_EC
	nop	
	
	la $k0, ln6
	jal change_EC
	nop	
	
	la $k0, ln7
	jal change_EC
	nop	
	
	la $k0, ln8
	jal change_EC
	nop	
	
	la $k0, ln9
	jal change_EC
	nop	
	
	la $k0, ln10
	jal change_EC
	nop	
	
	la $k0, ln11
	jal change_EC
	nop	
	
	la $k0, ln12
	jal change_EC
	nop	
	
	la $k0, ln13
	jal change_EC
	nop	
	
	la $k0, ln14
	jal change_EC
	nop	
	
	la $k0, ln15
	jal change_EC
	nop	
	
	la $k0, ln16
	jal change_EC
	nop
	
	j print
change_EC:
	li $a1, 22		# 0->20 -> chu D, 21: dau cach 
			# 22-> 42 -> chữ C, 43: dau cach
			# 44-> 63 -> chữ E, 64: dau cach
			# 65-> \n
loop2_1:
	beq $a1, 43, end_EC
	add $a2,$a1,22
	add $s1, $k0,$a1
	add $s2, $k0,$a2
	lb $t1, 0($s1) #C
	lb $t2, 0($s2) #E
	sb $t1, 0($s2)
	sb $t2, 0($s1)  
	
	addi $a1, $a1, 1	# Tang bien dem len 1
	j loop2_1
end_EC: 
	jr $ra
change_CandD:
	la $k0, ln1
	jal change_CD
	nop
	
	la $k0, ln2
	jal change_CD
	nop
	
	la $k0, ln3
	jal change_CD
	nop	
	
	la $k0, ln4
	jal change_CD
	nop	
	
	la $k0, ln5
	jal change_CD
	nop	
	
	la $k0, ln6
	jal change_CD
	nop	
	
	la $k0, ln7
	jal change_CD
	nop	
	
	la $k0, ln8
	jal change_CD
	nop	
	
	la $k0, ln9
	jal change_CD
	nop	
	
	la $k0, ln10
	jal change_CD
	nop	
	
	la $k0, ln11
	jal change_CD
	nop	
	
	la $k0, ln12
	jal change_CD
	nop	
	
	la $k0, ln13
	jal change_CD
	nop	
	
	la $k0, ln14
	jal change_CD
	nop	
	
	la $k0, ln15
	jal change_CD
	nop	
	
	la $k0, ln16
	jal change_CD
	nop
	
	j print
change_CD:
	li $a1, 0		# 0->20 -> chu D, 21: dau cach 
			# 22-> 42 -> chữ C, 43: dau cach
			# 43-> 63 -> chữ E, 64: dau cach
			# 65-> \n
loop2_2:
	beq $a1, 21, end_CD
	add $a2,$a1,22
	add $s1, $k0,$a1
	add $s2, $k0,$a2
	lb $t1, 0($s1) #D
	lb $t2, 0($s2) #E
	sb $t1, 0($s2)
	sb $t2, 0($s1)  
	
	addi $a1, $a1, 1	# Tang bien dem len 1
	j loop2_2
end_CD: 
	jr $ra
color:
	la $a0, color_D
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	add $s1, $v0, $0
	jal check_colorD
	nop
colorC:	
	la $a0, color_C
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	add $s2, $v0, $0
	jal check_colorC
	nop
colorE:	
	la $a0, color_E
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	add $s3, $v0, $0
	jal check_colorE
	nop
	
	li $v0 11
	la $a0, ' '
	syscall
	
	la $k0, ln1
	jal change_color
	nop
	
	la $k0, ln2
	jal change_color
	nop
	
	la $k0, ln3
	jal change_color
	nop
	la $k0, ln4
	jal change_color
	nop
	
	la $k0, ln5
	jal change_color
	nop
	la $k0, ln6
	jal change_color
	nop
	
	la $k0, ln7
	jal change_color
	nop
	la $k0, ln8
	jal change_color
	nop
	
	la $k0, ln9
	jal change_color
	nop
	la $k0, ln10
	jal change_color
	nop
	
	la $k0, ln11
	jal change_color
	nop
	la $k0, ln12
	jal change_color
	nop
	
	la $k0, ln13
	jal change_color
	nop
	
	la $k0, ln14
	jal change_color
	nop
	
	la $k0, ln15
	jal change_color
	nop
	
	la $k0, ln16
	jal change_color
	nop
	
	la $a0, '\n'
	li $v0, 12
	syscall
	j print		
change_color:
 	li $a1,0
loop3:
	beq $a1, 21, change_C		# 0->20 -> chu D, 21: dau cach 
		
	add $k1, $k0, $a1
	lb $t1, 0($k1)			# Lay ra ki tu mau hien tai  	
	blt $t1, '0', skip_change		# < '0' -> khong phai mau -> Skip
    	bgt $t1, '9', skip_change		# > '9' -> khong phai mau -> Skip	
    	add $t1, $0, $s1		# Thay mau` bang ki tu $s1
    	sb $t1, 0($k1)			# Luu mau` vao chu D
skip_change:
	addi $a1,$a1,1
	j loop3
	addi $a1,$a1,1

change_C:
		beq $a1, 43, change_E	
		add $k1, $k0, $a1
	   	lb $t1, 0($k1)			
	  	blt $t1, '0', skip_change2	
    	   	bgt $t1, '9', skip_change2	
    	   	add $t1, $0, $s2		
    	   	sb $t1, 0($k1)			
skip_change2: 	add $a1, $a1, 1			
		j change_C
		addi $a1,$a1,1
		
change_E:
		beq $a1, 65, end_change		
		add $k1, $k0, $a1
	   	lb $t1, 0($k1)				   	
	   	nop
	  	blt $t1, '0', skip_change3	
	  	nop
    	   	bgt $t1, '9', skip_change3	
    	   	nop 
    	   	add $t1, $0, $s3		
    	   	sb $t1, 0($k1)			
skip_change3: 	add $a1, $a1, 1			
		j change_E	
end_change: 	jr $ra
check_colorD:
	blt $s1, 48, wrong		# < '0' -> khong phai mau -> loi
	nop
    	bgt $s1, 57, wrong		# > '9' -> khong phai mau -> loi
    	nop
end_check: jr $ra
wrong:
	li $v0,4
	la $a0, wrong_color
	syscall
	j color

check_colorC:
	blt $s2, 48, wrongC		# < '0' -> khong phai mau -> loi
	nop
    	bgt $s2, 57, wrongC		# > '9' -> khong phai mau -> loi
    	nop
end_checkC: jr $ra
wrongC:
	li $v0,4
	la $a0, wrong_color
	syscall
	j colorC
	
check_colorE:
	blt $s3, 48, wrongE		# < '0' -> khong phai mau -> loi
	nop
    	bgt $s3, 57, wrongE		# > '9' -> khong phai mau -> loi
    	nop
end_checkE: jr $ra
wrongE:
	li $v0,4
	la $a0, wrong_color
	syscall
	j colorE
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

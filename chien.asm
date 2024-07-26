.eqv SEVENSEG_LEFT    0xFFFF0011 # Dia chi cua den led 7 doan trai	
					#Bit 0 = doan a         
					#Bit 1 = doan b	
					#Bit 7 = dau . 
.eqv SEVENSEG_RIGHT   0xFFFF0010 # Dia chi cua den led 7 doan phai 

.eqv KEY_READY  0xFFFF0000        	# =1 if has a new keycode, auto clear after lw
.eqv KEY_CODE   0xFFFF0004         # ascii của ký tự nhập từ bàn phím
                                         
.eqv DISPLAY_CODE   0xFFFF000C   	# show ascii
.eqv DISPLAY_READY  0xFFFF0008   	# =1 if the display has already to do  
	                                # Auto clear after sw  
.eqv MASK_CAUSE_KEYBOARD  0x0000034     # Keyboard Cause    
#Mỗi dòng đại diện cho một địa chỉ bộ nhớ và chức năng của nó trong chương trình.
.data 
led_number    : .byte 63,6,91,79,102,109,125,7,127,111    # hiển thị led
                                                        # chữ số từ 0->9
string_input : .space 1000	# lưu ký tự nhập từ bàn phím
string_origin : .asciiz "bo mon ky thuat may tinh" 
right_num: .asciiz  "So ky tu nhap dung la: "  
ask_return: .asciiz "Ban co muon quay lai chuong trinh khong? "
speed1: .asciiz "\nToc do danh may trung binh: "
speed2: .asciiz " ky tu/giay xap xi "
speed3: .asciiz " ky tu/phut\n"
.text
      	li   $k0,  KEY_CODE              
	li   $k1,  KEY_READY                    
	li   $s0, DISPLAY_CODE              
	li   $s1, DISPLAY_READY 
main:
	li $s2, 0  # đếm số vòng lặp
	li $s3, 0  # đếm số ký tự nhập vào
	li $s4, 10   # để chia 10, lưu ở led trái
	li $s5, 200   # lưu số vòng lặp, chính là đơn vị thời gian để đo (4*250=1000ms=1s)
	li $t4, 0     # đếm số ký tự nhập dc trong 1 khoảng thời gian
	li $t5, 0
	li $t6, 0    # đếm tổng thời gian
loop:
waitforkey:
	lw $t1, 0($k1)	# $t1 = [$k1] = KEY_READY
	beqz $t1, makeintr
	addi $t4,$t4,1
	teqi $t1,1
makeintr:   # lặp 200 vòng xong thì xử lý ký tự 
	addi $s2, $s2, 1     # tăng số vòng lặp 
	div $s2, $s5
	mfhi $t7       # chia số vòng lặp cho 200, nếu dư=0 thì là được 1 vòng
	bnez $t7, sleep  # nếu chưa được 1 vòng thì sleep
	li $s2, 0
led_display:
	div $t4, $s4    # số ký tự nhập trong 1 chu kỳ chia 10
	mflo $t7        # lấy phần nguyên (để hiển thị ở led trái)
	la $s6, led_number   # lấy mảng lưu giá trị từng chữ số đèn led
	add $s6, $s6, $t7    # lấy chữ số cần hiển thị
	lb $a0,0($s6)
	jal   SHOW_7SEG_LEFT    # hiện thị phần nguyên ở led trái
	nop
	mfhi $t7          # lấy phần dư (để hiển thị ở led phải)
	la $s6, led_number  # lấy mảng lưu giá trị từng chữ số đèn led
	add $s6, $s6, $t7    # lấy chữ số cần hiển thị
	lb $a0,0($s6)
	jal   SHOW_7SEG_RIGHT    # hiện thị phần dư ở led phải
	nop
	li $t4, 0   # reset về 0 để bắt đầu chu kỳ mới
	beq $t5, 1, ask_continue
sleep:
	addi $t6, $t6, 5
	addi $v0, $zero, 32                   
	li $a0, 5              	# sleep 5 ms         
	syscall         
	nop           	                    
	b loop   
end_main:
	li $v0,10
	syscall
SHOW_7SEG_LEFT:  
	li   $t0,  SEVENSEG_LEFT 	# assign port's address                   
	sb   $a0,  0($t0)        	# assign new value                    
	jr   $ra 
SHOW_7SEG_RIGHT: 
	li   $t0,  SEVENSEG_RIGHT 	# assign port's address                  
	sb   $a0,  0($t0)         	# assign new value                   
	jr   $ra 
#xử lý trap
.ktext 0x80000180
get_caus: 
	mfc0 $t1, $13 # $t1 = Coproc0.cause
IsCount: 
	li $t2, MASK_CAUSE_KEYBOARD# if Cause value confirm Keyboard..
	and $at, $t1,$t2
	beq $at,$t2, ReadKey
	j end_process
ReadKey: 
	lb $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
WaitForDis: 
	lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
	beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
LoadKey:
 	sb $t0, 0($s0)              	# load ký tự vừa nhập từ bàn phím
        	la  $t7, string_input		# $t7 là địa chỉ chuỗi nhập vào
        	add $t7, $t7, $s3		
        	sb $t0, 0($t7)
        	addi $s3, $s3, 1
        	beq $t0, '\n', end           # đến "\n" thì kết thúc, bắt đầu so sánh        
end_process:
next_pc: 
	mfc0 $at, $14 # $at <= Coproc0.$14 = Coproc0.epc
	addi $at, $at, 4 # $at = $at + 4 (next instruction)
	mtc0 $at, $14 # Coproc0.$14 = Coproc0.epc <= $at
	eret # Return from exception
end: 
count_speed: 
	addi $a0,$0,1000
	div $t6,$a0
	mflo $t6
	div $s3,$t6
	mflo $s7
	addi $a0, $0,60
	mult $s3, $a0
	mflo $s6
	div  $s6, $t6
	mflo $s6
compare_length:
	li $t1, 0       # đếm số ký tự được xét
	li $t3, 0       # đếm số ký tự nhập đúng
	li $t8, 24      # độ dài của string_origin
	
	slt $t7,$s3,$t8			# so sánh độ dài xâu nhập từ bàn phím và xâu ban đầu
					# xâu nào ngắn hơn thì duyệt theo xâu đó
	add $t8, $zero, $s3            # nếu không thì xét theo $s4
	addi $t8, $t8, -1			# trừ 1 vì không xét '\n'
	bne $t7,1, print       # nếu $s4>$t8 thì check theo $t8
	add $t8, $zero, $s3            # nếu không thì xét theo $s4
	addi $t8, $t8, -1			# trừ 1 vì không xét '\n'
print:   # in ra string nhập từ bàn phím
        	addi $t1, $t1, 1
        	bge $t1, $s3, print_speed
        	j print
print_speed:        
        # in tốc độ gõ phím trung bình
        	li $v0,4
	la $a0,speed1
	syscall
	
	li $v0, 1
	move $a0,$s7
	syscall
	
	li $v0,4
	la $a0,speed2
	syscall
	
	li $v0, 1
	move $a0,$s6
	syscall
	
	li $v0,4
	la $a0,speed3
	syscall
	
	li $t1, 0
check_string:
	la $t2, string_input
	add $t2,$t2,$t1
	lb $t9, 0($t2)			# lấy ký tự thứ $t1 trong input_string lưu vào $t9 để so sánh với ký tự thứ $t1 ở string_origin
	
	la $s7, string_origin
	add $s7, $s7, $t1
	lb $t4, 0($s7)                 # lưu ký tự thứ $t1 trong string_origin lưu vào $t4
	
	bne $t4, $t9, continue        # nếu khác nhau thì vào CONTINUE, giống thì tăng $t3 rồi vào CONTINUE
	addi $t3, $t3, 1
continue:
	addi $t1, $t1, 1
	beq $t1, $t8, print_right        # nếu duyệt hết thì print
	j check_string

print_right: 
	li $v0, 4
	la $a0, right_num
	syscall
	
	li $v0, 1
	add $a0, $t3, $zero   # in số ký tự đúng
	syscall
	
	li $t5, 1
	li $t4, 0
	add $t4, $t3, $zero
	b led_display
ask_continue:
	li $v0, 50
	la $a0, ask_return
	syscall
	beq $a0, 0, main		
	b exit
exit:
	li $v0, 10
	syscall
	

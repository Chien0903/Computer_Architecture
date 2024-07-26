.data
	message1: .asciiz "Nhap chuoi so: "  
	message2: .asciiz "Ket qua: "
	string: .space 100
.text
main:
	li $v0, 4		#thông báo nhập chuỗi số
    	la $a0, message1
    	syscall
	li $v0, 8		#Đọc chuỗi số đầu vào		
	la $a0, string
	la $a1 ,100
	syscall
	la $t0, string	#$t0 chưa địa chỉ của chuỗi số
	li $t1,0		#t1 lưu kết quả là số nguyên sau khi chuyển đổi
a_to_i:	
	lb $t2,0($t0) 	#$t2 lưu kí tự đang xét
	beq $t2 ,10, done	#gặp xuống dòng thì kết thúc
	sub $t2, $t2, 48	#chuyển sang số thập phân tương ứng
	mul $t1, $t1, 10	
	add $t1, $t1, $t2	#cập nhật giá trị
	addi $t0,$t0,1	#chuyển sang phần tử kết tiếp
	j a_to_i
done: 
	li $v0, 4
    	la $a0, message2
    	syscall
	li $v0, 1           # Syscall 1 (print_integer)
    	move $a0, $t1       # Di chuyển kết quả sang $a0
    	syscall
    	li $v0, 10
   	syscall	
	

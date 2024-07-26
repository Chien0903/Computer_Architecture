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
.eqv KEYBOARD_CAUSE   0x0000034     # Keyboard Cause    
  
.data 
bytehex     : .byte 63,6,91,79,102,109,125,7,127,111    # hiển thị led
                                                        # chữ số từ 0->9
input_string : .space 1000	# lưu ký tự nhập từ bàn phím
string_origin : .asciiz "bo mon ky thuat may tinh" 
Message1: .asciiz "\nSo ky tu trong 1s:  "
Message2: .asciiz "\nBan vua nhap: "
right_num: .asciiz  "\nSo ky tu nhap dung la: "  
ask_return: .asciiz "\nBan co muon quay lai chuong trinh khong? "
speed1: .asciiz "\nToc do danh may trung binh: "
speed2: .asciiz " ky tu/giay\n"
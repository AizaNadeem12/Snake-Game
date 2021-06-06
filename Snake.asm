[org 0x0100]    
jmp  start
message:db   'Remaining lives:', 0
message1:db  'Total lives:', 0
message5:db 'Score:',0
oldisr: dd  0   
string: db '+' 
counter: dw 18
food:db 'o','&','='
food_count:dw 3
food_fond:dw 0
lives:dw 3
score:dw 0
snake:times 400 dw 2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2020,2022,2024,2026,2028,2030,2032,2034,2036,2036
starting:
	push ax
	push cx
	call clrscr
	call draw
	call print_reml
	call print_r_lives
	call print_remt
	call print_t_lives
	call print_sc
	call print_score
	mov ax,0xb800
	mov es,ax
	mov di,2000
	mov ax,0xDD20
	mov cx,18
	mov word[counter],18
	mov si,cx
	shl si,1
nextchar:
	mov [snake+si],di
	mov [es:di],ax
	add di,2
	sub si,2
	loop nextchar
	mov ax,0x0440
	mov [es:di],ax
	mov [snake+si],di
	call food_placing
	pop cx
	pop ax
	ret
sound:
	push ax
	mov al,182
	out 0x43,al
	mov ax,6000
	out 0x42,al
	mov al,ah
	out 0x42,al
	in al,0x61
	or al,0x03
	out 0x61,al
	call delay
	call delay
	call delay
	in al,0x61
	and al,0xFC
	out 0x61,al
	pop ax
	ret
draw:
	mov ax,0xb800
	mov es,ax
	mov di,320
	mov ah,0x77
	mov al,[string]
	mov cx,80
n1:
	mov [es:di],ax
	add di,2
	loop n1
	mov di,320
	mov ah,0x77
	mov al,[string]
	mov cx,25
n2:
	mov [es:di],ax
	add di,160
	loop n2
	mov di,3998
	mov ah,0x77
	mov al,[string]
	mov cx,80
n3:
	mov [es:di],ax
	sub di,2
	loop n3
	mov di,478
        	mov ah,0x77
	mov al,[string]
	mov cx,80
n4:
	mov [es:di],ax
	add di,160
	loop n4
	ret
print_t_lives:
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	mov ax,0xb800
	mov es,ax
	mov ax,3
	mov bx,10
	mov cx,0
nextdigit:
	mov dx,0
	div bx
	add dl,0x30
	push dx
	inc cx
	cmp ax,0
	jnz nextdigit
	mov di,90
nextpos:
	pop dx
	mov dh,0x07
	mov [es:di],dx
	add di,2
	loop nextpos
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	ret 
print_score:
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	mov ax,0xb800
	mov es,ax
	mov ax,[score]
	mov bx,10
	mov cx,0
nextdigitt:
	mov dx,0
	div bx
	add dl,0x30
	push dx
	inc cx
	cmp ax,0
	jnz nextdigitt
	mov di,140
	push ax
	mov ax,0x0720
	mov [es:di],ax
	pop ax
nextposs:
	pop dx
	mov dh,0x07
	mov [es:di],dx
	add di,2
	loop nextposs
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	ret 
print_r_lives:
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	mov ax,0xb800
	mov es,ax
	mov ax,[lives]
	mov bx,10
	mov cx,0
nextdigit1:
	mov dx,0
	div bx
	add dl,0x30
	push dx
	inc cx
	cmp ax,0
	jnz nextdigit1
	mov di,36
nextpos1:
	pop dx
	mov dh,0x07
	mov [es:di],dx
	add di,2
	loop nextpos1
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	ret 
food_placing:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	add ax,9
	add ax,bx
	add ax,cx
	add ax,dx
	add ax,si
	add ax,starting
	add ax,print_t_lives
	add ax,print_r_lives
	add ax,food_found
	add ax,print_reml
	add ax,print_remt
	add ax,sound
	add ax,draw
	add ax,delay
	add ax,clrscr
	add ax,kbisr
	add ax,nomatch
	mov bx,1998
	mov dx,0
	div bx
	shl dx,1
	mov ax,0xb800
	mov es,ax
	mov si,dx
	cmp dx,320
	jbe boun
	mov bx,[es:si]
	cmp bl,[string]
	je boun
	mov cx,[counter]
	mov bx,0
chck:
	cmp si,[snake+bx]
	je boun
	add bx,2
	loop chck
	jmp boun1
boun:
	mov dx,1980
boun1:
	mov di,dx
	mov dx,0
	mov bx,3
	mov ax,[counter]
	div bx
	mov bx,dx
	mov ah,0x09
	mov al,[food+bx]
	mov[es:di],ax
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
print_reml:
	 push es
	 push ax
                   push cx 
                   push si   
                   push di 
 	 push ds  
                   pop  es  
	mov  di,message
	mov  cx, 0xffff       
                  xor  al, al           
	repne scasb          
	mov  ax, 0xffff        
	sub  ax, cx          
	dec  ax                
	jz   exit 
              	mov  cx, ax       
	mov  ax, 0xb800 
	mov  es, ax   
	mov  al, 80 
	mov bl,0
	mul  bl
	add  ax,0 
	shl  ax, 1   
	mov  di,ax          
	mov  si,message     
	mov  ah, 07
 	cld                 
nxd:
	lodsb               
	stosw                  
	loop nxd
exit: 
        pop  di   
        pop  si 
        pop  cx
        pop  ax 
        pop  es
        ret 

print_sc:
	 push es
	 push ax
                   push cx 
                   push si   
                   push di 
 	 push ds  
                   pop  es  
	mov  di,message5
	mov  cx, 0xffff       
                  xor  al, al           
	repne scasb          
	mov  ax, 0xffff        
	sub  ax, cx          
	dec  ax                
	jz   eit 
              	mov  cx, ax       
	mov  ax, 0xb800 
	mov  es, ax   
	mov  al, 80 
	mov bl,0
	mul  bl
	add  ax,60
	shl  ax,1  
	mov  di,ax          
	mov  si,message5   
	mov  ah, 07
 	cld                 
nexd:
	lodsb               
	stosw                  
	loop nexd
eit: 
        pop  di   
        pop  si 
        pop  cx
        pop  ax 
        pop  es
        ret 
print_remt:
	 push es
	 push ax
                   push cx 
                   push si   
                   push di 
 	 push ds  
                   pop  es  
	mov  di,message1
	mov  cx, 0xffff       
                  xor  al, al           
	repne scasb          
	mov  ax, 0xffff        
	sub  ax, cx          
	dec  ax                
	jz   exit1
              	mov  cx, ax       
	mov  ax, 0xb800 
	mov  es, ax   
	mov  al, 80 
	mov bl,0   
	mul  bl
	add  ax,30
	shl  ax, 1   
	mov  di,ax          
	mov  si,message1     
	mov  ah, 07
 	cld                 
nxd1:
	lodsb               
	stosw                  
	loop nxd1
exit1: 
        pop  di   
        pop  si 
        pop  cx
        pop  ax 
        pop  es
        ret 
delay:
	push cx
	mov cx,0xffff
stop:	sub cx,2
	cmp cx,0
	loop stop
	mov cx,0xffff
stop1:	sub cx,2
	cmp cx,0
	loop stop1
	mov cx,0xffff
stop2:	sub cx,2
	cmp cx,0
	loop stop2
	pop cx
	ret
clrscr:
	push es
            	push ax   
           	push cx     
       	push di
 	mov  ax, 0xb800    
                  mov  es, ax          
	xor  di, di           
                  mov  ax, 0x0720
                  mov  cx, 2000 
              	cld                
	rep  stosw             
             	pop  di 
 	pop  cx   
	pop  ax
                   pop  es   
                   ret 
food_found:
	push cx
	push bx
	mov bx,0
	mov cx,[food_count]
oop:
	cmp dl,[food+bx]
	je ff
	add bx,1
	loop oop
	mov word[food_fond],0
	jmp fff
ff:
	mov word[food_fond],1
fff:
	pop bx
	pop cx
	ret
len_inc:
	push si
	push cx
	push ax
	push bx
	mov cx,[counter]
	mov si,cx
	shl si,1
	add word[counter],4
	mov cx,4
	mov ax,[snake+si]
mem:
	sub ax,2
	mov [snake+si+2],ax
	add si,2
	loop mem
	pop bx
	pop ax
	pop cx
	pop si
	ret
kbisr:  
	push ax
	push es
	mov  ax, 0xb800
	mov  es, ax
label:
                  in   al, 0x60   
                  cmp  al, 0x4D      
	je  right
	jmp check
right:
	mov dx,0
loop1:
	mov cx,[counter]
	mov si,cx
	shl si,1
	mov ax,0x0720
	mov di,[snake+si]
	mov[es:di],ax
loo1:
	mov ax,[snake+si-2]
	mov [snake+si],ax
	sub si,2
	loop loo1
	add word[snake],2
	mov ax,0x0440
	mov di,[snake]
	mov dx,[es:di]
	mov [es:di],ax
	mov si,0
	mov ax,0xDD20
	mov cx,[counter]
nextrchar:
	add si,2
	mov di, [snake+si]
	mov [es:di],ax
	loop nextrchar
	mov di,[snake]
	call delay
	in   al, 0x60 
                  cmp  al, 0x4D  
	je  right
	cmp  al, 0x48     
	je  preup
	cmp  al, 0x50
	je  predown1
	mov cx,[counter]
	mov bx,2
	mov ax,di
chwck:
	cmp ax,[snake+bx]
	je bor
	add bx,2
	loop chwck
	call food_found
	cmp word[food_fond],1
	je incc
border:	
	cmp dl,[string]
	jne loop1
bor:
	sub word[lives],1
	call starting
	jmp nomatch
incc:
	add word[score],1
	call print_score
	call sound
	call len_inc
	cmp word[lives],240
	je bor
	call food_placing
	jmp border
check:
	cmp  al, 0x4B
	je  left
	jmp check1
end:
	jmp end1
preup:
	jmp up
predown1:
	jmp down
left:
	mov dx,0
loop2:
	mov cx,[counter]
	mov si,cx
	shl si,1
	mov ax,0x0720
	mov di,[snake+si]
	mov[es:di],ax
loo2:
	mov ax,[snake+si-2]
	mov [snake+si],ax
	sub si,2
	loop loo2
	sub word[snake],2
	mov ax,0x0440
	mov di,[snake]
	mov dx,[es:di]
	mov [es:di],ax
	mov si,0
	mov ax,0xDD20
	mov cx,[counter]
nextlchar:
	add si,2
	mov di, [snake+si]
	mov [es:di],ax
	loop nextlchar
	mov di,[snake]
	call delay
	in   al, 0x60
	cmp  al, 0x4B
	je  left
	cmp  al, 0x48     
	je  up
	cmp  al, 0x50
	je  predown
	mov cx,[counter]
	mov bx,2
	mov ax,di
chwck1:
	cmp ax,[snake+bx]
	je bor1
	add bx,2
	loop chwck1
	call food_found
	cmp word[food_fond],1
	je inc1
border1:	
	cmp dl,[string]
	jne loop2
bor1:
	sub word[lives],1
	call starting
	jmp nomatch
inc1:
	add word[score],1
	call print_score
	call sound
	call len_inc
	call food_placing
	jmp border1
end1:
	jmp end2
check1:
	cmp  al, 0x48     
	je  up
	jmp check2
predown:
	jmp down
up:
	mov dx,0
loop3:
	mov cx,[counter]
	mov si,cx
	shl si,1
	mov ax,0x0720
	mov di,[snake+si]
	mov[es:di],ax
	mov di,[snake+si-2]
	mov[es:di],ax
loo3:
	mov ax,[snake+si-2]
	mov [snake+si],ax
	sub si,2
	loop loo3
	sub word[snake],160
	mov ax,0x0440
	mov di,[snake]
	mov dx,[es:di]
	mov [es:di],ax
	mov si,0
	mov ax,0xDD20
	mov cx,[counter]
nextuchar:
	add si,2
	mov di, [snake+si]
	mov [es:di],ax
	loop nextuchar
	mov di,[snake]
	call delay
	in   al, 0x60 
                  cmp  al, 0x4D       
	je  right
	cmp  al, 0x4B
	je  left
	cmp  al, 0x48     
	je  up
	mov cx,[counter]
	mov bx,2
	mov ax,di
chwck2:
	cmp ax,[snake+bx]
	je bor2
	add bx,2
	loop chwck2
	call food_found
	cmp word[food_fond],1
	je inc2
border2:	
	cmp dl,[string]
	jne loop3
bor2:
	sub word[lives],1
	call starting
	jmp nomatch
inc2:
	add word[score],1
	call print_score
	call sound
	call len_inc
	call food_placing
	jmp border2
end2:
	jmp nomatch
check2:
	cmp  al, 0x50
	je  down
	jmp nomatch
down:
	mov dx,0
loop4:
	mov cx,[counter]
	mov si,cx
	shl si,1
	mov ax,0x0720
	mov di,[snake+si]
	mov[es:di],ax
loo4:
	mov ax,[snake+si-2]
	mov [snake+si],ax
	sub si,2
	loop loo4
	add word[snake],160
	mov ax,0x0440
	mov di,[snake]
	mov dx,[es:di]
	mov [es:di],ax
	mov si,0
	mov ax,0xDD20
	mov cx,[counter]
nextdchar:
	add si,2
	mov di, [snake+si]
	mov [es:di],ax
	loop nextdchar
	mov di,[snake]
	call delay
	in   al, 0x60 
                  cmp  al, 0x4D   
	je  right
	cmp  al, 0x4B
	je  left
	cmp  al, 0x50
	je  down
	mov cx,[counter]
	mov bx,2
	mov ax,di
chwck3:
	cmp ax,[snake+bx]
	je bor3
	add bx,2
	loop chwck3
	call food_found
	cmp word[food_fond],1
	je inc3
border3:
	cmp dl,[string]
	jne loop4
bor3:
	sub word[lives],1
	call starting
	jmp nomatch
inc3:
	add word[score],1
	call print_score
	call sound
	call len_inc
	call food_placing
	jmp border3
nomatch:
	 mov  al, 0x20              
	 out  0x20, al        
              pop  es     
              pop  ax       
            ; jmp far [cs:oldisr]          
             iret
start:    
	call starting
	xor  ax, ax 
                  mov  es, ax          
                  mov ax, [es:9*4] 
                  mov [oldisr], ax    
	mov ax, [es:9*4+2]
                  mov [oldisr+2], ax    
	cli                  
	mov  word [es:9*4], kbisr 
	mov  [es:9*4+2], cs   
	sti
l1:	
	cmp word[lives],0
	jne l1
	call clrscr
	mov ax, [oldisr]       
	mov bx, [oldisr+2]
	cli
	mov [es:9*4], ax      
	mov [es:9*4+2], bx      
	sti
mov ax,0x4c00
int 0x21